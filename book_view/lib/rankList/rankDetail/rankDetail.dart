import 'package:flutter/material.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/rankList/rankDetail/V/leftList.dart';
import 'package:book_view/rankList/rankDetail/V/rightList.dart';


class RankDetailView extends StatefulWidget {
  final Map data;

  RankDetailView({Key key, @required this.data}):super(key:key);
  @override
  RankDetailViewDetail createState() => new RankDetailViewDetail(model: this.data);
}

class RankDetailViewDetail extends State<RankDetailView> {
  Map model;

  RankDetailViewDetail({Key key, @required this.model,});
  RankDetailRightList rightList;
  Widget leftList;
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setup());
  }
  setup(){
    rightList = RankDetailRightList(source: model);

    leftList = RankDetailLeftList(selectedBack: (String chn){
      rightList.selectedTypeWithChn(chn);
    },);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model['name']),
        backgroundColor: XColor.appBarColor,
        textTheme: TextTheme(title: XTextStyle.navigationTitleStyle),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0.0),
            child: new Container(
              width: 60.0,
              child: Center(
                child: leftList,
              ),
            ),
          ),
          Expanded(
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
