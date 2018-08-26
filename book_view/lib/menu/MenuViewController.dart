import 'package:flutter/material.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/read/readViewController.dart';
import 'package:book_view/Global/dataHelper.dart';
import 'package:book_view/Global/V/XHUD.dart';


class MenuViewController extends StatefulWidget{
  final String url;
  final String bookName;
  MenuViewController({Key key,this.url,this.bookName}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MenuViewControllerState(url: url,bookName: bookName);
  }
}
class MenuViewControllerState extends State<MenuViewController> {
  String url;
  String bookName;
  List chapters=[];
  List links;
  XHud hud = XHud(
    backgroundColor: Colors.black12,
    color: Colors.white,
    containerColor: Colors.black26,
    borderRadius: 5.0,
  );

  MenuViewControllerState({Key key,this.url,this.bookName});

  @override
  initState(){
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getDataFromHttp());
  }

  getDataFromHttp()async{
    hud.state.showWithString("正在搜索目录信息");
    DataHelper.readDataFromTable(table: "Chapter");
    XHttp.getWithCompleteUrl(url, {}, (String response) async{
      hud.state.showWithString("正在分析目录信息");

      response = response.replaceAll(RegExp("\r|\n|\\s"), "");
      print(response);
      XRegexObject find = new XRegexObject(text: response);
      String chapterRegex = r'<dd><ahref=".*?">(.*?)</a></dd>';
      String linkRegex = r'<dd><ahref="(.*?)">.*?</a></dd>';


      chapters = find.getListWithRegex(chapterRegex);
      links = find.getListWithRegex(linkRegex);

      hud.state.showWithString("正在更新本地目录");

      DataHelper db = await getDataHelp();
      db.insertChapterList(bookName, chapters, links);

      hud.state.showWithString("正在加载目录");

      setState(() {

      });
      hud.state.dismiss();
    });
  }

  Widget renderRow(i) {

    if (i.isOdd) {
      return new Container(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: new Divider(height: 1.0),
      );
    }
    i = i ~/ 2;
    return new InkWell(
      child: Text(chapters[i],style: TextStyle(fontSize: 18.0),),
      onTap: () {
        String url = links[i];
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new ReadViewController(url: "https://www.biqudu.com"+url,title: chapters[i],bookName: bookName,)
        ));
      },
    );;
  }

  @override
  Widget build(BuildContext context) {
    var list = DataHelper.readDataFromTable(table: "Chapter");
//    for(var item in list){
//      print(item);
//    }
//
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("目录"),
          backgroundColor: XColor.appBarColor,
          textTheme: TextTheme(title: XTextStyle.navigationTitleStyle),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body:Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: new ListView.builder(
                itemCount: chapters.length*2,
                itemBuilder: (context, i) => renderRow(i),
              ),
            ),
            hud,
          ],
        )
    );;
  }
}