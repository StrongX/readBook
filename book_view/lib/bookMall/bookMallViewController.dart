import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:book_view/dataHelper/dataHelper.dart';
class BookMall extends StatelessWidget {

  test()async{

    DataHelper db = await getDataHelp();
//    print('----');
//    await db.insertChapter("1111", "222", "3333");
    db.closeDataBase();
  }

  @override
  Widget build(BuildContext context) {
    test();
    final title = 'Cached Images';

    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body:Text(""),
      ),
    );
  }
}