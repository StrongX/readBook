import 'package:flutter/material.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/read/readViewController.dart';
import 'package:book_view/Global/dataHelper.dart';
import 'package:book_view/Global/V/XHUD.dart';

class MenuViewController extends StatefulWidget {
  final String url;
  final String bookName;
  MenuViewController({Key key, this.url, this.bookName}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MenuViewControllerState(url: url, bookName: bookName);
  }
}

class MenuViewControllerState extends State<MenuViewController> {
  String url;
  String bookName;
  List menuList = [];
  Map regexData;
  XHud hud = XHud();

  MenuViewControllerState({Key key, this.url, this.bookName});

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showMenuList());
  }

  showMenuList() async {
    regexData = await DefaultSetting.getMenuRegexData();
    DataHelper db = await getDataHelp();
    menuList = await db.getChapterList(bookName);
    if (menuList.length == 0) {
      getDataFromHttp();
      print("从网络加载列表");
    } else {
      if (url == null) {
        Map chapter = menuList.first;
        url = chapter['menuLink'];
      }
      print("直接显示列表");
      setState(() {});
      updateDataFromHttp();
    }
  }

  getDataFromHttp() async {
    hud.state.showWithString("正在搜索目录信息");
    XHttp.getWithCompleteUrl(url, {}, (String response) async {
      hud.state.showWithString("正在分析目录信息");

      response = response.replaceAll(RegExp("\r|\n|\\s"), "");
      print(response);
      XRegexObject find = new XRegexObject(text: response);
      String chapterRegex = regexData['regex']['chapterRegex'];
      String linkRegex = regexData['regex']['linkRegex'];

      List titles = find.getListWithRegex(chapterRegex);
      List links = find.getListWithRegex(linkRegex);
      print(titles);
      hud.state.showWithString("正在更新本地目录");

      DataHelper db = await getDataHelp();
      await db.insertChapterList(bookName, titles, links, url);

      menuList = await db.getChapterList(bookName);

      hud.state.showWithString("正在加载目录");

      setState(() {});
      hud.state.dismiss();
    });
  }

  updateDataFromHttp() async {
    print("更新列表");
    XHttp.getWithCompleteUrl(url, {}, (String response) async {
      response = response.replaceAll(RegExp("\r|\n|\\s"), "");
      XRegexObject find = new XRegexObject(text: response);
      String chapterRegex = regexData['regex']['chapterRegex'];
      String linkRegex = regexData['regex']['linkRegex'];

      List titles = find.getListWithRegex(chapterRegex);
      List links = find.getListWithRegex(linkRegex);
      DataHelper db = await getDataHelp();
      await db.insertChapterList(bookName, titles, links, url);
      menuList = await db.getChapterList(bookName);
      setState(() {});
      print("更新成功");
    });
  }

  Widget renderRow(i) {
    Map chapter = menuList[i];
    return new InkWell(
      child: Column(
        children: <Widget>[
          Align(
            alignment: FractionalOffset.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                chapter['chapterName'],
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Divider(
              height: 1.0,
            ),
          )
        ],
      ),
      onTap: () async {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new ReadViewController(
                  chapter: chapter,
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("目录"),
          backgroundColor: XColor.appBarColor,
          textTheme: TextTheme(title: XTextStyle.navigationTitleStyle),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: menuList.length,
              itemBuilder: (context, i) => renderRow(i),
            ),
            hud,
          ],
        ));
  }
}
