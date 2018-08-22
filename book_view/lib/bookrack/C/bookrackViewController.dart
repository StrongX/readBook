import 'package:flutter/material.dart';
import 'package:book_view/Global/dataHelper.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/read/readViewController.dart';
import 'package:book_view/searchBook/searchResultViewController.dart';

class BookRack extends StatefulWidget {
  @override
  BookRackState createState() => new BookRackState();
}

class BookRackState extends State<BookRack> {

  BookRackState(){
    getRackList();
  }
  getRackList()async{
    DataHelper db = await getDataHelp();
    print('---');
    List list = await db.database.rawQuery("select * from ChapterCache");
    print(list.length);
    rackList = await db.getRackList();
    setState(() {
    });
    await db.closeDataBase();
  }
  updateRackList()async{
    DataHelper db = await getDataHelp();
    rackList = await db.getRackList();
    await db.closeDataBase();
  }
  List rackList=[];



  startRead(index) async{
    Map book = rackList[index];
    if(book['currentChapter'] == null){
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (ctx) => SearchResultViewController(bookName: book['bookName'],)
      ));
    }else{
      DataHelper db = await getDataHelp();
      Map chapter = await db.getChapter(book['bookName'], book['currentChapter']);
      if(chapter==null){
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => SearchResultViewController(bookName: book['bookName'],)
        ));
      }else{
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) =>  ReadViewController(url: chapter['link'],title: chapter['chapterName'],bookName: chapter['bookName'],)
        ));
      }
      await db.closeDataBase();

    }
  }




  Widget renderRow(i) {

    if (i.isOdd) {
      return new Container(
        padding: EdgeInsets.fromLTRB(102.0, 0.0, 0.0, 0.0),
        child: new Divider(height: 1.0),
      );
    }
    i = i ~/ 2;
    Map book = rackList[i];
    String thumbImgUrl = book['cover'];
    if (!thumbImgUrl.startsWith(RegExp('^http'))) {
      thumbImgUrl = "http://" + thumbImgUrl;
    }
    var thumbImg = new Container(
      width: 102.0,
      height: 136.0,
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xFFECECEC),
        image: new DecorationImage(
            image: new ExactAssetImage('./images/01.jpg'), fit: BoxFit.cover),
        border: new Border.all(
          color: const Color(0xFFECECEC),
          width: 2.0,
        ),
      ),
    );
    if (thumbImgUrl != null && thumbImgUrl.length > 0) {
      thumbImg = new Container(
        width: 102.0,
        height: 136.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFECECEC),
          image: new DecorationImage(
              image: new NetworkImage(thumbImgUrl), fit: BoxFit.cover),
          border: new Border.all(
            color: const Color(0xFFECECEC),
            width: 2.0,
          ),
        ),
      );
    }

    var titleRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text('${i + 1}.' + book['bookName'],
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0)),
        )
      ],
    );

    var authorRow = new Row(
      children: <Widget>[
        new Expanded(
//          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            book['author'] + " | " + book['type'],
            style: TextStyle(
                color: const Color.fromRGBO(168, 168, 168, 1.0),
                fontSize: 12.0),
          ),
        ),
      ],
    );
    String intro = book['desc'];
    intro = intro.replaceAll(RegExp('\\s'), '');
    var descRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text(
            intro,
            style: TextStyle(
                color: const Color.fromRGBO(92, 92, 92, 1.0), fontSize: 13.0),
            maxLines: 2,
          ),
        ),
      ],
    );
    var lastChapterRow = new Row(
      children: <Widget>[
        new Expanded(
//          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            book['lastChapter'] + "  \n. " + book['lastChapterDate'],
            style: TextStyle(
                color: const Color.fromRGBO(107, 125, 167, 1.0),
                fontSize: 11.0),
          ),
        ),
      ],
    );
    var row = new Row(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: new Container(
            width: 102.0,
            height: 136.0,
            color: const Color(0xFFECECEC),
            child: new Center(
              child: thumbImg,
            ),
          ),
        ),
        new Expanded(
          flex: 1,
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Column(
              children: <Widget>[
                titleRow,
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                  child: authorRow,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                  child: descRow,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                  child: lastChapterRow,
                ),
              ],
            ),
          ),
        ),
      ],
    );
    return new InkWell(
      child: row,
      onTap: (){
        startRead(i);
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    updateRackList();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("书架"),
        backgroundColor: XColor.appBarColor,
        textTheme: TextTheme(title: XTextStyle.navigationTitleStyle),
      ),
      body:Container(
        padding: const EdgeInsets.all(.0),
        child: new ListView.builder(
          itemCount: rackList.length * 2,
          itemBuilder: (context, i) => renderRow(i),
        ),
      ),
    );
  }



}
