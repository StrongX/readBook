import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_view/read/flutter_html_widget.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/Global/XPrint.dart';
import 'package:book_view/Global/XContants.dart';

class ReadViewController extends StatefulWidget {
  final String url;
  final String title;
  ReadViewController({Key key, this.url,this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ReadViewControllerState(url: url,title: this.title);
}

class ReadViewControllerState extends State<ReadViewController> {
  String url;
  String title;
  String content='';

  ReadViewControllerState({Key key, this.url,this.title}){
    getDataFromHttp();
  }

  getDataFromHttp(){
    XHttp.getWithCompleteUrl(url, {}, (String response){
      response = response.replaceAll(RegExp("\r|\n"), "");
      XRegexObject find = new XRegexObject(text: response);
      String contentRegex = r'<div id="content">(.*?)</div>';
      setState(() {
        content = find.getListWithRegex(contentRegex)[0];
      });
    });
  }

  AppBar _appBar;
  var showAppBar = false;
  showTipView(){
    setState(() {
      if(showAppBar == false){

        showAppBar = true;
        _appBar = AppBar(
          title: Text(title),
          backgroundColor: XColor.appBarColor,
          textTheme: TextTheme(title: XTextStyle.readTitleStyle),
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.menu,color: Colors.white,), onPressed: null),
          ],
        );
      }else{
        showAppBar = false;
        _appBar = null;
      }
    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appBar,
      backgroundColor: Color.fromRGBO(247, 235, 157, 1.0),
      body:GestureDetector(child: new HtmlWidget(
        html: content,
      ),
        onTap:showTipView ,
      )
    );
  }
}
