import 'package:flutter/material.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/bookDetail/bookDetailViewController.dart';
import 'package:book_view/tools/XRegexObject.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'dart:async';
import 'package:book_view/Global/V/XHUD.dart';
import 'package:book_view/Global/XContants.dart';
class RankDetailRightList extends StatefulWidget {
  final Map source;
  RankDetailRightListState state;
  void selectedTypeWithChn(String chn) {
    state.selectedTypeWithChn(chn);
  }

  RankDetailRightList({Key key, this.source}) : super(key: key);

  @override
  RankDetailRightListState createState() {
    state = RankDetailRightListState(source: this.source,);
    return state;
  }
}

class RankDetailRightListState extends State<RankDetailRightList> {
  final Map source;

  RankDetailRightListState({Key key, this.source});
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getDataFromHttp());
  }

  List titles = [];
  List covers = [];
  List authors = [];
  List types = [];
  List intros = [];
  List lasts = [];
  List lastDates = [];
  List links = [];
  int page = 1;
  String _chn = "-1";

  XHud hud = XHud();


  RefreshController refreshState = RefreshController();
  getDataFromHttp() {

    hud.state.show();
    String path = source['path'];
    XHttp.getWithCompleteUrl(path, {"page": "$page", "chn": _chn},
        (String response) async{
      response = response.replaceAll(RegExp("\r|\n"), "");
      XRegexObject find = new XRegexObject(text: response);
      if (page == 1) {
        titles = [];
        covers = [];
        authors = [];
        types = [];
        intros = [];
        lasts = [];
        lastDates = [];
        links = [];
      }
      Map regex = await DefaultSetting.getRankRegex();
      titles.addAll(find.getListWithRegex(regex['titleRegex']));
      covers.addAll(find.getListWithRegex(regex['coverRegex']));
      authors.addAll(find.getListWithRegex(regex['authorRegex']));
      types.addAll(find.getListWithRegex(regex['typeRegex']));
      intros.addAll(find.getListWithRegex(regex['introRegex']));
      lasts.addAll(find.getListWithRegex(regex['lastRegex']));
      lastDates.addAll(find.getListWithRegex(regex['lastDateRegex']));
      links.addAll(find.getListWithRegex(regex['linkRegex']));
      setState(() {});
      refreshState.sendBack(true, RefreshStatus.idle);
      refreshState.sendBack(false, RefreshStatus.idle);
      hud.state.dismiss();
    });
  }

  Widget renderRow(i) {
    String thumbImgUrl = covers[i];
    if (!thumbImgUrl.startsWith(RegExp('^http'))) {
      thumbImgUrl = "https://" + thumbImgUrl;
    }
    var thumbImg = new Container(
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
    if (thumbImgUrl != null && thumbImgUrl.length > 0) {}

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
    var row = Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
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
            Expanded(
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
        ),
        Divider(height: 1.0,),
      ],
    );
    return new InkWell(
      child: row,
      onTap: () {
        print(titles[i]);
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new BookDetailViewController(
                  bookName: titles[i],
                  link: links[i],
                  cover: covers[i],
                  desc: intros[i],
                  type: types[i],
                  author: authors[i],
                  lastChapter: lasts[i],
                  lastChapterDate: lastDates[i],
                )));
      },
    );
  }

  void _onRefresh(bool up) {
    new Future.delayed(const Duration(milliseconds: 1000)).then((val) {
      if (up) {
        //headerIndicator callback
        page = 1;
        print("last page");
      } else {
        //footerIndicator Callback
        page++;
        print('next Page');
      }
      getDataFromHttp();
    });
  }

  void selectedTypeWithChn(String chn) {
    print(chn);
    _chn = chn;
    page = 1;
    getDataFromHttp();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(.0),
        child: Stack(
          children: <Widget>[
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: _onRefresh,
              onOffsetChange: null,
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, i) => renderRow(i),
              ),
              controller: refreshState,
            ),
            hud,
          ],
        ));
  }
}
