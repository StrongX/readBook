import 'package:flutter/material.dart';
import 'package:book_view/Global/XContants.dart';
class ReadTopView extends StatefulWidget{

  ReadTopView({Key key,}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReadTopViewSate();
  }
}
//显示按钮，目录界面，书籍详情界面，缓存操作
class ReadTopViewSate extends State<ReadTopView>{

  TextStyle buttonStyle = TextStyle(color: Colors.white);
  Widget topView() {

    return Column(
      children: <Widget>[
        Padding(
          padding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: Container(
            height: 20.0,
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Container(
                child: FlatButton.icon(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back, color: XColor.fontColor),
                  label: Text(""),
                ),
                width: 60.0,
              ),
              Expanded(
                child: Container(),
              ),
              Align(
                child: Row(

                  children: <Widget>[
                    FlatButton(
                      child: Text("目录",style: buttonStyle,),
                      onPressed: (){
                        print("目录");
                      },
                    ),
                    FlatButton(
                      child: Text("详情",style: buttonStyle,),
                      onPressed: (){
                        print("详情");
                      },
                    ),
                    FlatButton(
                      child: Text("刷新",style: buttonStyle,),
                      onPressed: (){
                        print("刷新");
                      },
                    ),


                  ],
                ),
                alignment: FractionalOffset.centerRight,
              )
            ],
          ),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context){
    return Container(
      height: 64.0,
      color: Color.fromRGBO(0, 0, 0, 0.8),
      child: topView(),
    );
  }
}