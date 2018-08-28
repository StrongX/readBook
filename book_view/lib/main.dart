import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'bookrack/C/bookrackViewController.dart';
import 'rankList/rankListViewController.dart';
import 'Global/XContants.dart';
import 'package:flutter/services.dart';
void main() => runApp(new MyApp());



class MyApp extends StatefulWidget {
  @override
  HomeAppState createState() => new HomeAppState();
}

class HomeAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  int _tabIndex = 0;



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return new MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: new Scaffold(
        body: new IndexedStack(
          children: <Widget>[
            new BookRack(),
//            new BookMall(),
            new RankList(),
          ],
          index: _tabIndex,
        ),
        bottomNavigationBar: new CupertinoTabBar(
          activeColor: XColor.redColor,
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: new Icon(Icons.bookmark), title: new Text("书架")),
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.store_mall_directory),
//                title: new Text("书城")),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.local_library), title: new Text("找书")),
          ],
          currentIndex: _tabIndex,
          onTap: (index){
            setState(() {
              _tabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
