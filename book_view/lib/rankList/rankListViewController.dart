import 'package:flutter/material.dart';
import 'package:book_view/rankList/V/rankListView.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/searchBook/searchResultViewController.dart';

class RankList extends StatefulWidget {
  @override
  RankListState createState() => new RankListState();
}

class RankListState extends State<RankList> {
  RankListView listView = new RankListView();


  getRankTypeList(){
    DefaultSetting.getRankList((List typeList){
        listView.loadDataWithList(typeList);
    });
  }

  @override
  initState(){
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getRankTypeList());
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
