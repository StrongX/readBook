import 'package:flutter/material.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/Global/XPrint.dart';
import 'package:book_view/menu/MenuViewController.dart';

class SearBookViewController extends StatefulWidget{
  final String bookName;
  SearBookViewController({Key key,this.bookName}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearBookViewControllerState(bookName: bookName);
  }
}
class SearBookViewControllerState extends State<SearBookViewController> {
  String bookName;
  List titles = [];
  List covers;
  List authors;
  List intros;
  List links;
  SearBookViewControllerState({Key key,this.bookName}){
    getDataFromHttp();
  }

  getDataFromHttp(){
    XHttp.getWithCompleteUrl("https://www.biqudu.com/searchbook.php?keyword="+bookName, {}, (String response){
      response = response.replaceAll(RegExp("\r|\n|\\s"), "");
      XRegexObject find = new XRegexObject(text: response);
      String titleRegex = r'<dl><dt><span>.*?</span><ahref=".*?">(.*?)</a></dt><dd>.*?</dd></dl>';
      String coverRegex = r'<ahref=".*?"><imgsrc="(.*?)"alt=".*?"width="120"height="150"/>';
      String authorRegex = r'<dl><dt><span>(.*?)</span><ahref=".*?">.*?</a></dt><dd>.*?</dd></dl>';
      String linkRegex = r'<dl><dt><span>.*?</span><ahref="(.*?)">.*?</a></dt><dd>.*?</dd></dl>';
      String introRegex = r'<dd>(.*?)</dd>';
      setState(() {
        titles = find.getListWithRegex(titleRegex);
        covers = find.getListWithRegex(coverRegex);
        authors = find.getListWithRegex(authorRegex);
        links = find.getListWithRegex(linkRegex);
        intros = find.getListWithRegex(introRegex);
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
    String thumbImgUrl = covers[i];
    if (!thumbImgUrl.startsWith(RegExp('^http'))) {
      thumbImgUrl = "https://www.biqudu.com/" + thumbImgUrl;
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
          child: new Text('${i + 1}.' + titles[i],
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0)),
        )
      ],
    );

    var authorRow = new Row(
      children: <Widget>[
        new Expanded(
//          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            authors[i],
            style: TextStyle(
                color: const Color.fromRGBO(168, 168, 168, 1.0),
                fontSize: 12.0),
          ),
        ),
      ],
    );
    String intro = intros[i];
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

              ],
            ),
          ),
        ),
      ],
    );
    return new InkWell(
      child: row,
      onTap: () {
        String url = links[i];
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new MenuViewController(url: "https://www.biqudu.com"+url,bookName: titles[i],)
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索结果"),
        backgroundColor: XColor.appBarColor,
        textTheme: TextTheme(title: XTextStyle.navigationTitleStyle),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:Container(
        padding: EdgeInsets.all(10.0),
        child: new ListView.builder(
          itemCount: titles.length*2,
          itemBuilder: (context, i) => renderRow(i),
        ),
      )
    );;
  }
}