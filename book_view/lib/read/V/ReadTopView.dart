import 'package:flutter/material.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/bookDetail/bookDetailViewController.dart';
import 'package:book_view/Global/dataHelper.dart';
import 'package:book_view/menu/MenuViewController.dart';


class ReadTopView extends StatefulWidget{
  final Map chapter;

  ReadTopView({Key key,this.chapter}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReadTopViewState();
  }
}
class PopMenuItemObject {
  const PopMenuItemObject({ this.title, this.icon ,this.value});
  final String title;
  final IconData icon;
  final int value;
}
const List<PopMenuItemObject> menuItems = const <PopMenuItemObject>[
  const PopMenuItemObject(title: '书籍信息', icon: Icons.book,value: 1),
  const PopMenuItemObject(title: '目录详情', icon: Icons.list,value: 2),
  const PopMenuItemObject(title: '缓存', icon: Icons.cached,value: 3),
  const PopMenuItemObject(title: '刷新', icon: Icons.refresh,value: 4),
];


//显示按钮，目录界面，书籍详情界面，缓存操作
class ReadTopViewState extends State<ReadTopView>{

  TextStyle buttonStyle = TextStyle(color: Colors.white);

  void _select(PopMenuItemObject item) {
    if(item.value == 1){
//      Navigator.of(context).push(new MaterialPageRoute(
//          builder: (ctx) => BookDetailViewController(
//            bookName: titles[i],
//            link: links[i],
//            cover: covers[i],
//            desc: intros[i],
//            type: types[i],
//            author: authors[i],
//            lastChapter: lasts[i],
//            lastChapterDate: lastDates[i],
//          )));
    }else if(item.value == 2){
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (ctx) => new MenuViewController(bookName: widget.chapter['bookName'],)
      ));
    }else if(item.value == 3){

    }else if(item.value == 4){

    }
  }

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
                child: PopupMenuButton<PopMenuItemObject>( // overflow menu
                  onSelected: _select,
                  itemBuilder: (BuildContext context) {
                    return menuItems.map((PopMenuItemObject item) {
                      return new PopupMenuItem<PopMenuItemObject>(
                        value: item,
                        child: Row(children: <Widget>[Icon(item.icon),Text(item.title)],)
                      );
                    }).toList();
                  },
                    icon: Icon(Icons.menu, color: XColor.fontColor),
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