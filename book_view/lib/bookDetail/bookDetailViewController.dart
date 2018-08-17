import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_view/read/readViewController.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/searchBook/searBookViewController.dart';
class BookDetailViewController extends StatefulWidget {
  final String bookName;
  final String link;
  final String cover;
  final String desc;
  final String type;
  final String author;
  final String lastChapter;
  final String lastChapterDate;
  BookDetailViewController({Key key, this.bookName,this.link,this.cover,this.desc,this.type,this.author,this.lastChapter,this.lastChapterDate});

  @override
  State<StatefulWidget> createState() =>
      new BookDetailViewControllerState(bookName: this.bookName,link: this.link,cover: cover,desc: desc,type: type,author: this.author,lastChapter: this.lastChapter,lastChapterDate: this.lastChapterDate);
}

class BookDetailViewControllerState extends State<BookDetailViewController> {
  String bookName;
  String link;
  String cover;
  String desc;
  String type;
  String author;
  String shortIntro='';
  String lastChapter;
  String lastChapterDate;
  BookDetailViewControllerState({Key key, this.bookName,this.link,this.cover,this.desc,this.type,this.author,this.lastChapter,this.lastChapterDate}){
    getDataFromHttp();
  }

  getDataFromHttp(){
    if (!link.startsWith(RegExp('^http'))) {
      link = "https://" + link;
    }
    XHttp.getWithCompleteUrl(link, {}, (String response){
      response = response.replaceAll(RegExp("\r|\n"), "");
      XRegexObject find = new XRegexObject(text: response);
      String shortIntroRegex = r'<p class="intro">(.*?)</p>';

      setState(() {
        shortIntro = find.getListWithRegex(shortIntroRegex)[0];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var titleRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text(bookName, style: new TextStyle(fontSize: 15.0, color: new Color.fromRGBO(33, 33, 33, 1.0)),),
        )
      ],
    );
    var authorRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text(author+' 著 | 类型: '+type, style: new TextStyle(fontSize: 12.0, color: new Color.fromRGBO(78, 78, 78, 1.0)),),
        )
      ],
    );
    var shortIntroRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text(
            shortIntro,
            style: new TextStyle(fontSize: 12.0, color: new Color.fromRGBO(33, 33, 33, 1.0)),
          ),
        ),
      ],
    );

    readNow(){
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (ctx) => SearBookViewController(bookName: bookName,)
      ));
    }

    var btnRow = new Row(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
          height: 30.0,
          child: new RaisedButton(
            onPressed: readNow,
            child: new Text("立即阅读",style: TextStyle(fontSize: 12.0),),
            color: new Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ),
        new Container(
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
          height: 30.0,
          child: new RaisedButton(
            onPressed: (){print("加入书架");},
            child: new Text("加入书架",style: TextStyle(fontSize: 12.0),),
            color: new Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ),
      ],
    );
    if (!cover.startsWith(RegExp('^http'))) {
      cover = "http://" + cover;
    }
    Widget bookInfo = new Container(
      child: Row(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(15.0),
            child: new Container(
              width: 80.0,
              height: 100.0,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFECECEC),
                image: new DecorationImage(
                    image: new NetworkImage(cover), fit: BoxFit.cover),
                border: new Border.all(
                  color: const Color(0xFFECECEC),
                  width: 2.0,
                ),
              ),
            ),
          ),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              child: new Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 4.0),
                  child: titleRow,),
                  authorRow,
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                    child: shortIntroRow,
                  ),
                  new Padding(
                    padding: EdgeInsets.all(0.0),
                    child: btnRow,
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );


    Widget renderRow(i) {

      if (i.isOdd) {
        return new Divider(height: 1.0);
      }
      i = i ~/ 2;
      var titleRow = new Row(
        children: <Widget>[
          new Expanded(
            child: new Text('书友20170727164900641',style: TextStyle(fontSize: 12.0,color: Color.fromRGBO(55, 80, 136, 1.0)),),
          )
        ],
      );
      var contentRow = new Row(
        children: <Widget>[

          new Expanded(
            child: new Text(
              '总觉得青虹怜命运不会太好，“怜”嘛。就像《红楼梦》的甄英莲（“真应怜”）一样',
            ),
          ),
        ],
      );
      var timeRow = new Row(
        children: <Widget>[

          new Expanded(
            child: new Text(
              '2018-08-04 21:17',
              style: TextStyle(fontSize: 11.0,color: Color.fromRGBO(196, 196, 196, 1.0)),
            ),
          ),
        ],
      );
      var thumbImgUrl = 'https://facepic.qidian.com/qd_face/349573/0/50';
      var thumbImg = new Container(
        margin: const EdgeInsets.all(0.0),
        width: 50.0,
        height: 50.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFECECEC),
          image: new DecorationImage(
              image: new ExactAssetImage('./images/ic_img_default.jpg'),
              fit: BoxFit.cover),

        ),
      );
      if (thumbImgUrl != null && thumbImgUrl.length > 0) {
        thumbImg = new Container(
          margin: const EdgeInsets.all(0.0),
          width: 50.0,
          height: 50.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFECECEC),
            image: new DecorationImage(
                image: new NetworkImage(thumbImgUrl), fit: BoxFit.cover),

          ),
        );
      }
      var row = new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(0.0),
            child: new Container(
              width: 50.0,
              height: 50.0,
              color: const Color(0xFF),
              child: new Center(
                child: thumbImg,
              ),
            ),
          ),
          new Expanded(
            flex: 1,
            child: new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  titleRow,
                  contentRow,
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                    child: timeRow,
                  )
                ],
              ),
            ),
          ),

        ],
      );
      return new InkWell(
        child: row,
        onTap: () {
          print(i);
        },
      );
    }
    desc = desc.replaceAll(RegExp('\\s'), '');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(bookName),
        backgroundColor: XColor.appBarColor,
        textTheme: TextTheme(title: XTextStyle.navigationTitleStyle),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: new ListView(
        children: <Widget>[
          bookInfo,
          new Padding(padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),child: new Divider(height: 1.0,)),
          new Padding(padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),child: new Text("目录信息",style: TextStyle(fontSize: 17.0),),),
          new Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 8.0),child: new Text(lastChapter+"\n"+lastChapterDate,style: TextStyle(fontSize: 13.0,color: Color.fromRGBO(107, 125, 167, 1.0),),),),

          new Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),child: new Divider(height: 1.0,)),

          new Padding(padding: EdgeInsets.fromLTRB(15.0, 15.0, .0, 10.0),child: new Text("作品信息",style: TextStyle(fontSize: 17.0),),),
          new Padding(padding: EdgeInsets.fromLTRB(15.0, .0, 15.0, .0),child: new Text(desc,style: TextStyle(fontSize: 14.0,color: Color.fromRGBO(53, 53, 53, 1.0)),),),
          new Padding(padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),child: new Divider(height: 1.0,)),
//          new Padding(padding: EdgeInsets.fromLTRB(15.0, 15.0, .0, .0),child: new Text("书友评论",style: TextStyle(fontSize: 17.0),),),
//          renderRow(0),
//          renderRow(1),
//          renderRow(2),
//          renderRow(3),
//          renderRow(4),

//          new Padding(padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),child: new Divider(height: 1.0,)),
        ],
      ),
    );
  }
}
