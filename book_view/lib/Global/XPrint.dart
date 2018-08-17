import 'package:flutter/material.dart';

class XPrint{
  final String text;
  int lineNumber = 200;
  XPrint({Key key,this.text}){
      for(int i = 0;;i++){
        int start = i*lineNumber;
        int end = start+lineNumber;
        if(end>this.text.length){
          print(this.text.substring(start));
          break;
        }else{
          print(this.text.substring(start,end));
        }
      }
  }
}