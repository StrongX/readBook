import 'package:flutter/material.dart';

class ReadBottomView extends StatefulWidget{
  final VoidCallback nextChapter;
  final VoidCallback lastChapter;

  ReadBottomView({Key key,this.nextChapter,this.lastChapter}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReadBottomViewState(nextChapter:nextChapter,lastChapter: lastChapter);
  }
}
class ReadBottomViewState extends State<ReadBottomView>{

  var row;
  ReadBottomViewState({nextChapter,lastChapter}){
    row=Stack(
      children: <Widget>[
        Align(
            alignment: FractionalOffset.centerLeft,
            child: Padding(padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                child: Text("上一章",style: TextStyle(color: Colors.white,fontSize: 14.0),),
                onTap:lastChapter,
              ),
            )
        ),
        Align(
            alignment: FractionalOffset.centerRight,
            child: Padding(padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                child: Text("下一章",style: TextStyle(color: Colors.white,fontSize: 14.0),),
                onTap:nextChapter,
              ),
            )
        )
      ],
    );
  }



  @override
  Widget build(BuildContext context){
    return Container(
      height: 44.0,
      color: Color.fromRGBO(0, 0, 0, 0.8),
      child: row,
    );
  }
}