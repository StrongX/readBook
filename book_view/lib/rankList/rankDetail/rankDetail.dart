import 'package:flutter/material.dart';

import 'package:book_view/Global/XContants.dart';
import 'package:book_view/rankList/rankDetail/V/leftList.dart';
import 'package:book_view/rankList/rankDetail/V/rightList.dart';


class RankDetailView extends StatefulWidget {
  final Map data;
  final List typeList;
  final Map regex;
  RankDetailView({Key key, @required this.data ,@required this.typeList,this.regex}):super(key:key);
  @override
  RankDetailViewDetail createState() => new RankDetailViewDetail(model: this.data,typeList: this.typeList,regex: this.regex);
}

class RankDetailViewDetail extends State<RankDetailView> {
  Map model;
  List typeList;
  Map regex;

  RankDetailViewDetail({Key key, @required this.model, this.typeList,this.regex});





  @override
  Widget build(BuildContext context) {
    RankDetailRightList rightList = RankDetailRightList(source: model,regex: regex);

    Widget leftList = RankDetailLeftList(typeList: typeList,selectedBack: (String chn){
      rightList.selectedTypeWithChn(chn);
    },);


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
