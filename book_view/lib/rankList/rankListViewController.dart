import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/rankList/V/rankListView.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/Global/XHttp.dart';

class RankList extends StatefulWidget {
  @override
  RankListState createState() => new RankListState();
}

class RankListState extends State<RankList> {
  RankListView listView = new RankListView();

  RankListState(){
    XHttp.get('/rankList', {}, (String response) {
      Map model = json.decode(response);
      if (model['code'] == 100) {
        listView.loadDataWithList(model['rankList'],model['typeList'],model['doMain'],model['regex']);
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("排行榜"),
        backgroundColor: XColor.appBarColor,
        textTheme: TextTheme(title: XTextStyle.navigationTitleStyle),
      ),
      body: listView,
    );
  }
}
