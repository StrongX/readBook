import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/read/V/ReadBottomView.dart';
import 'package:book_view/Global/dataHelper.dart';
import 'package:book_view/Global/cacehHelper.dart';
import 'package:book_view/read/V/ReadHtmlParser.dart';
import 'package:book_view/read/V/ReadTopView.dart';
import 'package:book_view/Global/Adnet.dart';
import 'package:book_view/Global/V/XHUD.dart';
import 'package:book_view/Global/XContants.dart';

class ReadViewController extends StatefulWidget {
  final Map chapter;

  ReadViewController({Key key,  this.chapter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new ReadViewControllerState(chapter: chapter);
}

class ReadViewControllerState extends State<ReadViewController> {
  XHud hud = XHud();
  String content = '';
  Map chapter;
  ScrollController scroll = ScrollController();
  ReadHtmlParser contentObject;
  double maxOffset=0.0;
  double minOffSet=0.0;

  Map dataRegex = DefaultSetting.getReadRegexData();

  ReadViewControllerState({Key key,this.chapter}) {
    contentObject = ReadHtmlParser();
    getDataFromHttp();
  }

  int readCount = 0;

  getDataFromHttp() async {
    DataHelper db = await getDataHelp();
    db.updateCurrentChapter(chapter['bookName'], chapter['chapterName']);
    CacheHelper.cacheBookAuto(chapter['bookName'], chapter['chapterName']);
    double offset = await db.getOffset(chapter['bookName']);

    if(readCount%5==4){
      AdNet.show();
    }
    if(readCount%5==0){
      AdNet.load();
    }
    readCount++;
    await CacheHelper.getChapterContent(chapter['bookName'], chapter['chapterName'], chapter['link'],
        (String chapterCache) {
      XRegexObject find = new XRegexObject(text: chapterCache);
      String contentRegex = dataRegex['regex']['contentRegex'];
      content = find.getListWithRegex(contentRegex)[0];
      setState(() {
      });
      if(offset == null){
        scroll.animateTo(0.0, duration: new Duration(milliseconds: 200), curve: Curves.ease);
      }else{
        scroll.animateTo(offset, duration: new Duration(milliseconds: 200), curve: Curves.ease);
      }
    });
  }


  double toolOpacity = 0.0;
  var showAppBar = false;
  showTipView() {
    setState(() {
      if (showAppBar == false) {
        showAppBar = true;
        toolOpacity = 1.0;
      } else {
        showAppBar = false;
        toolOpacity = 0.0;
      }
    });
  }

  nextChapter() async {
    print("next");
    DataHelper db = await getDataHelp();
    await db.updateOffset(chapter['bookName'], 0.0);
    chapter = await db.getNextChapter(chapter['bookName'], chapter["id"]);
    if (chapter != null) {
      getDataFromHttp();
    }
  }

  lastChapter() async {
    print("last");
    DataHelper db = await getDataHelp();
    await db.updateOffset(chapter['bookName'], 0.0);
    chapter = await db.getLastChapter(chapter['bookName'], chapter["id"]);
    if (chapter != null) {
      getDataFromHttp();
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if(notification is ScrollUpdateNotification){
      double offset = notification.metrics.pixels;
      if(offset<minOffSet){
        minOffSet = offset;
      }
      if(offset>maxOffset){
        maxOffset = offset;
      }
    }
    if(notification is ScrollEndNotification){
      //下滑到最底部
      double offset = notification.metrics.pixels;
      updateOffset(offset);
      if(notification.metrics.extentAfter==0.0){
        if(maxOffset-notification.metrics.maxScrollExtent>100){
          nextChapter();
          maxOffset=0.0;
          minOffSet=0.0;
        }
      }
      //滑动到最顶部
      if(notification.metrics.extentBefore==0.0){
        if(minOffSet<-100){
          lastChapter();
          minOffSet=0.0;
          maxOffset=0.0;
        }
      }
    }
    return false;
  }
  updateOffset(double offset)async{
    DataHelper db = await getDataHelp();
    db.updateOffset(chapter['bookName'], offset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(247, 235, 157, 1.0),
        body: Stack(
          children: <Widget>[
            GestureDetector(
              child: NotificationListener(child: contentObject.getParseListFromStr(content,scroll,chapter['chapterName']),
                onNotification: _handleScrollNotification,
              ),
              onTap: showTipView,
            ),
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Opacity(
                opacity: toolOpacity,
                child: ReadTopView(
                  chapter: this.chapter,
                  hud: this.hud,
                  reload: (){
                    getDataFromHttp();
                  },
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Opacity(
                opacity: toolOpacity,
                child: ReadBottomView(
                  nextChapter: nextChapter,
                  lastChapter: lastChapter,
                ),
              ),
            ),
            hud,
          ],
        ));
  }
}
