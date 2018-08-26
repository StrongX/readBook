import 'package:flutter/material.dart';

class BlankView extends StatelessWidget{
  final String tipText;
  BlankView({Key key,this.tipText});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
      child: Container(
        width: 150.0,
        height: 200.0,
        child: Column(
          children: <Widget>[
            Container(
              width: 150.0,
              child: Image.asset('./images/blank.png'),
            ),
            Text(tipText,style: TextStyle(color: Colors.black26,fontSize: 12.0),),
          ],
        )
      ),
      alignment: AlignmentDirectional.center,
    );

  }
}