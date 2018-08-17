import 'package:flutter/material.dart';

import 'package:book_view/Global/XContants.dart';
import 'package:book_view/rankList/rankDetail/V/leftList.dart';
import 'package:book_view/rankList/rankDetail/V/rightList.dart';

class RankDetailView extends StatefulWidget {
  final Map data;
  final List typeList;
  final String doMain;
  final Map regex;
  RankDetailView({Key key, @required this.data ,@required this.typeList,this.doMain,this.regex}):super(key:key);
  @override
  RankDetailViewDetail createState() => new RankDetailViewDetail(model: this.data,typeList: this.typeList,doMain: this.doMain,regex: this.regex);
}

class RankDetailViewDetail extends State<RankDetailView> {
  Map model;
  List typeList;
  String doMain;
  Map regex;
  RankDetailViewDetail({Key key, @required this.model, this.typeList,this.doMain,this.regex});





  @override
  Widget build(BuildContext context) {

    Widget leftList = RankDetailLeftList(typeList: typeList,);

    Widget rightList = RankDetailRightList(source: model,doMain: doMain,regex: regex,);

    return Scaffold(
      appBar: AppBar(
        title: Text(model['name']),
        backgroundColor: XColor.appBarColor,
        textTheme: TextTheme(title: XTextStyle.navigationTitleStyle),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Row(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(0.0),
            child: new Container(
              width: 60.0,
              child: new Center(
                child: leftList,
              ),
            ),
          ),
          new Expanded(
            child: new Container(
              child: new Center(
                child: rightList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
