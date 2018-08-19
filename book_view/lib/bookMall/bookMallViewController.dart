import 'package:flutter/material.dart';
import 'package:book_view/read/V/ReadBottomView.dart';
class BookMall extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BookMallState();
  }
}
class BookMallState extends State<BookMall>{

  @override
  Widget build(BuildContext context) {
    final title = 'Cached Images';

    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Demo'),
        ),
        body: new Stack(//第一个子控件最下面
          //statck
          children: <Widget>[

            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                height: 44.0,
                child: ReadBottomView(nextChapter: (){
                  print("111");
                },),
              ),
            ),
          ],
        ),
      ),
    );
  }
}