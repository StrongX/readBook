import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/rankList/V/rankListView.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/searchBook/searchResultViewController.dart';
import 'package:dio/dio.dart';

class RankList extends StatefulWidget {
  @override
  RankListState createState() => new RankListState();
}

class RankListState extends State<RankList> {
  RankListView listView = new RankListView();

  RankListState(){
    XHttp.get('/rankList', {}, (Map response) {
      if (response['code'] == 100) {
        listView.loadDataWithList(response['rankList'],response['typeList'],response['doMain'],response['regex']);
      }
    },(DioError e){
      Map response = DefaultSetting.getDefaultSetting();
      listView.loadDataWithList(response['rankList'],response['typeList'],response['doMain'],response['regex']);
    });
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("排行榜"),
        backgroundColor: XColor.appBarColor,
        textTheme: TextTheme(title: XTextStyle.navigationTitleStyle),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (ctx) => SearchResultViewController(bookName: "",)
                ));
              }),
        ],
      ),
      body: listView,
    );
  }
}
