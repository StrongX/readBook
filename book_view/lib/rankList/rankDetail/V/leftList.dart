import 'package:flutter/material.dart';
import 'package:book_view/Global/XContants.dart';

typedef void SelectedType(String chn);

class RankDetailLeftList extends StatefulWidget{

  final SelectedType selectedBack;
  RankDetailLeftList({Key key,this.selectedBack}):super(key:key);
  @override
  RankDetailLeftListState createState() => new RankDetailLeftListState();
}

class RankDetailLeftListState extends State<RankDetailLeftList>{
  RankDetailLeftListState({Key key});

  final TextStyle normalSelectedStyle = new TextStyle(fontSize: 13.0, color: Color.fromRGBO(88, 88, 88, 1.0));
  final TextStyle selectedStyle = new TextStyle(fontSize: 13.0, color: Color.fromRGBO(234, 57, 79, 1.0));

  int typeSelected = 0;
  List typeList = [];

  @override
  initState(){
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getTypeList());
  }

  getTypeList(){
    setState(() {
      typeList = DefaultSetting.getTypeList();
    });
  }

  Widget renderRow(index) {
    Map data = typeList[index];
    var row;
    var childrenWidget;
    if (index == typeSelected) {
      row = Text(
        data['name'],
        style: selectedStyle,
      );
      childrenWidget = [
        new Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: Container(
            width: 4.0,
            height: 30.0,
            color: XColor.redColor,
          ),
        ),
        new Expanded(
          child: new InkWell(
            child: new Container(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
              child: row,
            ),
            onTap: () {
              setState(() {
                typeSelected = index;
              });
            },
          ),
        )
      ];
    } else {
      row = Text(
        data['name'],
        style: normalSelectedStyle,
      );
      childrenWidget = [
        new Expanded(
          child: new InkWell(
            child: new Container(
              padding: EdgeInsets.fromLTRB(12.0, 8.0, 0.0, 8.0),
              child: row,
            ),
            onTap: () {
              typeSelected = index;
              Map type = typeList[index];
              widget.selectedBack(type['chn']);
              setState(() {
              });
            },
          ),
        )
      ];
    }
    return new Container(
        padding: EdgeInsets.all(0.0),
        width: 60.0,
        child: new Row(
          children: childrenWidget,
        ));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(.0),
      width: 100.0,
      child: new ListView.builder(
        itemCount: typeList.length,
        itemBuilder: (context, i) => renderRow(i),
      ),
    );
  }

}