import 'package:flutter/material.dart';
import 'package:book_view/Global/XContants.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/Global/XPrint.dart';
import 'package:book_view/menu/MenuViewController.dart';
import 'package:book_view/Global/dataHelper.dart';
import 'package:book_view/Global/V/XHUD.dart';
class SearchResultViewController extends StatefulWidget{
  final String bookName;
  SearchResultViewController({Key key,this.bookName}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchResultViewControllerState(bookName: bookName);
  }
}
class SearchResultViewControllerState extends State<SearchResultViewController> {
  String bookName;
  List titles = [];
  List covers;
  List authors;
  List intros;
  List links;
  TextField searchField;
  TextEditingController editController;
  XHud hud = XHud(
    backgroundColor: Colors.black12,
    color: Colors.white,
    containerColor: Colors.black26,
    borderRadius: 5.0,
  );
  SearchResultViewControllerState({Key key,this.bookName});
  @override
  initState(){
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getDataFromHttp());
  }

  getDataFromHttp(){
    if(bookName == "" || bookName == null){
      return;
    }
    hud.state.showWithString("正在搜索书籍资源");
    XHttp.getWithCompleteUrl("https://www.biqudu.com/searchbook.php?keyword="+bookName, {}, (String response){
      response = response.replaceAll(RegExp("\r|\n|\\s"), "");
      XRegexObject find = new XRegexObject(text: response);
      String titleRegex = r'<dl><dt><span>.*?</span><ahref=".*?">(.*?)</a></dt><dd>.*?</dd></dl>';
      String coverRegex = r'<ahref=".*?"><imgsrc="(.*?)"alt=".*?"width="120"height="150"/>';
      String authorRegex = r'<dl><dt><span>(.*?)</span><ahref=".*?">.*?</a></dt><dd>.*?</dd></dl>';
      String linkRegex = r'<dl><dt><span>.*?</span><ahref="(.*?)">.*?</a></dt><dd>.*?</dd></dl>';
      String introRegex = r'<dd>(.*?)</dd>';
      setState(() {
        titles = find.getListWithRegex(titleRegex);
        covers = find.getListWithRegex(coverRegex);
        authors = find.getListWithRegex(authorRegex);
        links = find.getListWithRegex(linkRegex);
        intros = find.getListWithRegex(introRegex);
      });
      hud.state.dismiss();
    });
  }
  addRack(i)async{
    String thumbImgUrl = covers[i];
    if (!thumbImgUrl.startsWith(RegExp('^http'))) {
      thumbImgUrl = "https://www.biqudu.com/" + thumbImgUrl;
    }
    DataHelper db = await getDataHelp();
    await db.insertRack(bookName, thumbImgUrl, "", authors[i], "", "", intros[i], intros[i], "");

  }
  showMenuList(i){
    String url = links[i];
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (ctx) => new MenuViewController(url: "https://www.biqudu.com"+url,bookName: titles[i],)
    ));
  }
  Widget renderRow(i) {

    if (i.isOdd) {
      return new Container(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: new Divider(height: 1.0),
      );
    }
    i = i ~/ 2;
    String thumbImgUrl = covers[i];
    if (!thumbImgUrl.startsWith(RegExp('^http'))) {
      thumbImgUrl = "https://www.biqudu.com/" + thumbImgUrl;
    }
    var thumbImg = new Container(
      width: 102.0,
      height: 136.0,
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xFFECECEC),
        image: new DecorationImage(
            image: new ExactAssetImage('./images/01.jpg'), fit: BoxFit.cover),
        border: new Border.all(
          color: const Color(0xFFECECEC),
          width: 2.0,
        ),
      ),
    );
    if (thumbImgUrl != null && thumbImgUrl.length > 0) {
      thumbImg = new Container(
        width: 102.0,
        height: 136.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFECECEC),
          image: new DecorationImage(
              image: new NetworkImage(thumbImgUrl), fit: BoxFit.cover),
          border: new Border.all(
            color: const Color(0xFFECECEC),
            width: 2.0,
          ),
        ),
      );
    }

    var titleRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text('${i + 1}.' + titles[i],
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0)),
        )
      ],
    );

    var authorRow = new Row(
      children: <Widget>[
        new Expanded(
//          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            authors[i],
            style: TextStyle(
                color: const Color.fromRGBO(168, 168, 168, 1.0),
                fontSize: 12.0),
          ),
        ),
      ],
    );
    String intro = intros[i];
    intro = intro.replaceAll(RegExp('\\s'), '');
    var descRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text(
            intro,
            style: TextStyle(
                color: const Color.fromRGBO(92, 92, 92, 1.0), fontSize: 13.0),
            maxLines: 2,
          ),
        ),
      ],
    );
    var btnRow = new Row(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
          height: 30.0,
          child: new RaisedButton(
            onPressed: (){
              showMenuList(i);
            },
            child: new Text("查看目录",style: TextStyle(fontSize: 12.0),),
            color: new Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ),
        new Container(
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
          height: 30.0,
          child: new RaisedButton(
            onPressed: (){
              addRack(i);
            },
            child: new Text("加入书架",style: TextStyle(fontSize: 12.0),),
            color: new Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ),
      ],
    );
    var row = new Row(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: new Container(
            width: 102.0,
            height: 136.0,
            color: const Color(0xFFECECEC),
            child: new Center(
              child: thumbImg,
            ),
          ),
        ),
        new Expanded(
          flex: 1,
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Column(
              children: <Widget>[
                titleRow,
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                  child: authorRow,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                  child: descRow,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                  child: btnRow,
                ),
              ],
            ),
          ),
        ),
      ],
    );
    return new InkWell(
      child: row,
      onTap: () {
        showMenuList(i);
      },
    );
  }

  searchAction(){
    bookName = editController.text;
    getDataFromHttp();
  }

  Widget searchInput() {
    bool focus;
    if(bookName.isEmpty){
      focus = true;
    }else{
      focus = false;
    }
    if(searchField == null){
      editController = new TextEditingController(text: bookName);
      searchField = TextField(
        controller: editController,
        autofocus: focus,
        decoration: new InputDecoration.collapsed(
          hintText: "请输入书籍名称",
          hintStyle: new TextStyle(color: XColor.fontColor),
        ),
        onSubmitted: (String key){
          searchAction();
        },
      );
    }
    return new Container(
      height: 30.0,
      child: new Row(
        children: <Widget>[
          new Container(
            child: new FlatButton.icon(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: new Icon(Icons.arrow_back, color: XColor.fontColor),
              label: new Text(""),
            ),
            width: 60.0,
          ),
          new Expanded(
            child: Container(
              alignment: AlignmentDirectional.center,
              child: searchField,
            )
          ),
          new Padding(
            padding: EdgeInsets.all(0.0),
            child: Container(
              width: 40.0,
              child:GestureDetector(
                child: Text("确定",style: XTextStyle.barItemTStyle,),
                onTap: (){
                  searchAction();
                },
              ),
            )
          ),
        ],
      ),
      decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
          color: XColor.searchBackgroundColor
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home:  Scaffold(
          appBar: AppBar(
            title: searchInput(),
            backgroundColor: XColor.appBarColor,
            textTheme: TextTheme(title: XTextStyle.navigationTitleStyle),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body:Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: new ListView.builder(
                  itemCount: titles.length*2,
                  itemBuilder: (context, i) => renderRow(i),
                ),
              ),
              hud,
            ],
          )
      ),
    );
  }
}