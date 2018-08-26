import 'package:flutter/material.dart';
import 'package:book_view/rankList/rankDetail/rankDetail.dart';

class RankListView extends StatefulWidget {
  final RankListViewState listView = new RankListViewState();
  @override
  RankListViewState createState() {
    return listView;
  }
  loadDataWithList(rankList,typeList,regex){
    listView.loadDataWithList(rankList,typeList,regex);
  }
}


class RankListViewState extends State<RankListView> {

  clickItem(model){
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (ctx) => new RankDetailView(data: model,typeList: _typeList,regex: _regex,)
    ));
  }
  List _typeList;
  List dataSource=[];
  Map _regex;
  List<Widget> childsWidget = [];
  loadDataWithList(rankList,typeList,regex){
    _typeList = typeList;
    _regex = regex;
    setState(() {
      dataSource = rankList;
      childsWidget = [];
      for(var model in dataSource){
        childsWidget.add(new ListTile(
          title: new Text(model['name']),
          onTap: (){
            clickItem(model);
          },
        ));
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: childsWidget,
    );
  }
}