import 'package:flutter/material.dart';
import 'package:book_view/rankList/rankDetail/rankDetail.dart';

class RankListView extends StatefulWidget {
  final RankListViewState listView = new RankListViewState();
  @override
  RankListViewState createState() {
    return listView;
  }
  loadDataWithList(rankList){
    listView.loadDataWithList(rankList);
  }
}


class RankListViewState extends State<RankListView> {

  clickItem(model){
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (ctx) => new RankDetailView(data: model)
    ));
  }

  List<Widget> childWidget = [];
  loadDataWithList(rankList){
    setState(() {
      childWidget = [];
      for(var model in rankList){
        childWidget.add(new ListTile(
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
      children: childWidget,
    );
  }
}