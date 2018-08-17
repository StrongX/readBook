import 'package:flutter/material.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/read/readViewController.dart';
import 'package:book_view/dataHelper/dataHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

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
  MenuViewControllerState({Key key,this.url,this.bookName}){
    getDataFromHttp();
  }

  getDataFromHttp(){
    DataHelper.readDataFromTable(table: "Chapter");
    XHttp.getWithCompleteUrl(url, {}, (String response) async{
      response = response.replaceAll(RegExp("\r|\n|\\s"), "");
      XRegexObject find = new XRegexObject(text: response);
      String chapterRegex = r'<dd><ahref=".*?">(.*?)</a></dd>';
      String linkRegex = r'<dd><ahref="(.*?)">.*?</a></dd>';

      chapters = find.getListWithRegex(chapterRegex);
      links = find.getListWithRegex(linkRegex);
      DataHelper db = await getDataHelp();
      for(int i = 0; i<chapters.length;i++){
        await db.insertChapter(bookName, chapters[i], links[i]);
      }
      db.closeDataBase();

      setState(() {

      });
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
      child: Text(chapters[i]),
      onTap: () {
        String url = links[i];
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new ReadViewController(url: "https://www.biqudu.com"+url,title: chapters[i],)
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
        body:Container(
          padding: EdgeInsets.all(10.0),
          child: new ListView.builder(
            itemCount: chapters.length*2,
            itemBuilder: (context, i) => renderRow(i),
          ),
        )
    );;
  }
}