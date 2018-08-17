import 'package:flutter/material.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/bookDetail/bookDetailViewController.dart';
import 'package:book_view/tools/XRegexObject.dart';

class RankDetailRightList extends StatefulWidget {
  final Map source;
  final String doMain;
  final Map regex;
  RankDetailRightList({Key key, this.source, this.doMain, this.regex})
      : super(key: key);
  @override
  RankDetailRightListState createState() => new RankDetailRightListState(
      source: this.source, doMain: this.doMain, regex: this.regex);
}

class RankDetailRightListState extends State<RankDetailRightList> {
  final Map source;
  final String doMain;
  Map regex;
  RankDetailRightListState({Key key, this.source, this.doMain, this.regex}) {
    getDataFromHttp();
  }

  List titles = [];
  List covers;
  List authors;
  List types;
  List intros;
  List lasts;
  List lastDates;
  List links;
  getDataFromHttp() {
    XHttp.getWithDomain(doMain, source['path'], {}, (String response) {
      response = response.replaceAll(RegExp("\r|\n"), "");
      XRegexObject find = new XRegexObject(text: response);
      setState(() {
        titles = find.getListWithRegex(regex['titleRegex']);
        covers = find.getListWithRegex(regex['coverRegex']);
        authors = find.getListWithRegex(regex['authorRegex']);
        types = find.getListWithRegex(regex['typeRegex']);
        intros = find.getListWithRegex(regex['introRegex']);
        lasts = find.getListWithRegex(regex['lastRegex']);
        lastDates = find.getListWithRegex(regex['lastDateRegex']);
        links = find.getListWithRegex(regex['linkRegex']);
      });
    });
  }

  Widget renderRow(i) {
    if (i.isOdd) {
      return new Container(
        padding: EdgeInsets.fromLTRB(102.0, 0.0, 0.0, 0.0),
        child: new Divider(height: 1.0),
      );
    }
    i = i ~/ 2;
    String thumbImgUrl = covers[i];
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
            authors[i] + " | " + types[i],
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
    var lastChapterRow = new Row(
      children: <Widget>[
        new Expanded(
//          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            lasts[i] + "  \n. " + lastDates[i],
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
      onTap: () {
        print(titles[i]);
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new BookDetailViewController(bookName: titles[i],link: links[i],cover: covers[i],desc: intros[i],type: types[i],author: authors[i],lastChapter: lasts[i],lastChapterDate: lastDates[i],)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(.0),
      child: new ListView.builder(
        itemCount: titles.length * 2,
        itemBuilder: (context, i) => renderRow(i),
      ),
    );
  }
}
