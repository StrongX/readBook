import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_view/read/flutter_html_widget.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/Global/XPrint.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/read/V/ReadBottomView.dart';
import 'package:book_view/dataHelper/dataHelper.dart';

class ReadViewController extends StatefulWidget {
  final String title;
  final String bookName;
  final String url;
  ReadViewController({Key key, this.title, this.bookName,this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      new ReadViewControllerState(title: this.title, bookName: this.bookName,url: this.url);
}

class ReadViewControllerState extends State<ReadViewController> {
  String url;
  String title;
  String bookName;
  String content = '';
  Map chapter;
  ReadViewControllerState({Key key, this.url, this.title, this.bookName}) {
    getDataFromHttp();
  }

  getDataFromHttp() async {
    DataHelper db = await getDataHelp();
    if(chapter == null){
      List chapters = await db.getChapter(bookName, title);
      chapter = chapters.first;
    }
    db.updateCurrentChapter(bookName, title);
    await db.closeDataBase();
    XHttp.getWithCompleteUrl(url, {}, (String response) {
      response = response.replaceAll(RegExp("\r|\n"), "");
      XRegexObject find = new XRegexObject(text: response);
      String contentRegex = r'<div id="content">(.*?)</div>';
      setState(() {
        content = find.getListWithRegex(contentRegex)[0];
      });
    });
  }

  AppBar _appBar;
  var showAppBar = false;
  showTipView() {
    setState(() {
      if (showAppBar == false) {
        showAppBar = true;
        _appBar = AppBar(
          title: Text(title),
          backgroundColor: XColor.appBarColor,
          textTheme: TextTheme(title: XTextStyle.readTitleStyle),
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: null),
          ],
        );
      } else {
        showAppBar = false;
        _appBar = null;
      }
    });
  }

  nextChapter()async{
    DataHelper db = await getDataHelp();
    List chapters = await db.getNextChapter(bookName, chapter["id"]);
    if(chapters.length>0){
      chapter = chapters.first;
      title = chapter['chapterName'];
      url = chapter['link'];
      getDataFromHttp();
    }

    await db.closeDataBase();
  }
  lastChapter()async{
    DataHelper db = await getDataHelp();
    List chapters = await db.getLastChapter(bookName, chapter["id"]);
    if(chapters.length>0){
      chapter = chapters.first;
      title = chapter['chapterName'];
      url = chapter['link'];
      getDataFromHttp();
    }
    await db.closeDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar,
        backgroundColor: Color.fromRGBO(247, 235, 157, 1.0),
        body: Stack(
          children: <Widget>[
            GestureDetector(
              child: new HtmlWidget(
                html: content,
              ),
              onTap: showTipView,
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: ReadBottomView(
                nextChapter: nextChapter,
                lastChapter: lastChapter,
              ),
            )
          ],
        ));
  }
}
