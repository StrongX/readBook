import 'package:flutter/material.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class XColor{
  static const redColor = Color.fromRGBO(224, 90, 85, 1.0);
  static const appBarColor = redColor;
  static Color searchBackgroundColor = Colors.white10;

  static Color fontColor = Colors.white;

}
class XTextStyle{
  static const navigationTitleStyle = TextStyle(color: Colors.white,fontSize: 20.0);
  static const readTitleStyle = TextStyle(color: Colors.white,fontSize: 15.0);
  static const barItemTStyle = TextStyle(color: Colors.white,fontSize: 13.0);

}
class DefaultSetting{
  static getPref()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
  static getRankList(void callBack(List rankList)){
    XHttp.get('/rankList', {}, (Map response)async{
      int code = response['code'];
      if (code == 100) {
        print("------11112222222");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print("------1111");

        double myRegexVersion = prefs.getDouble("regexVersion");
        double regexVersion = response['regexVersion'];
        print('myRegexVersion:$myRegexVersion');
        print('regexVersion:$regexVersion');
        String rankList;
        if(myRegexVersion==null || regexVersion>myRegexVersion){
          print("get new");
          await prefs.setDouble('regexVersion', regexVersion);
          rankList = json.encode(response['rankList']);
          await prefs.setString("rankList", rankList);
          String typeList = json.encode(response['typeList']);
          await prefs.setString("typeList", typeList);
          String rankRegex = json.encode(response['rankRegex']);
          await prefs.setString("rankRegex", rankRegex);
          String qiDianIndexRegex = json.encode(response['qiDianIndexRegex']);
          await prefs.setString("qiDianIndexRegex", qiDianIndexRegex);
          String searchData = json.encode(response['searchData']);
          await prefs.setString("searchData", searchData);
          String menuData = json.encode(response['menuData']);
          await prefs.setString("menuData", menuData);
          String readData = json.encode(response['readData']);
          await prefs.setString("readData", readData);
        }else{
          print("get cache");
          rankList = prefs.getString('rankList');
        }
        if(rankList == null){
          await prefs.setDouble('regexVersion', 0.0);
          DefaultSetting.getRankList((List rank){
            callBack(rank);
          });
        }else{
          List ranks = json.decode(rankList);
          callBack(ranks);
        }
      }else{
        print("code:$code  get default");
        callBack(DefaultSetting.getDefaultRankTypeList());
      }
    },(DioError e){
      print("get default");
      print(e);
      callBack(DefaultSetting.getDefaultRankTypeList());
    });
  }
  static getDefaultRankTypeList(){
    List rankList = [];
    rankList.add({
      'name':'原创风云榜·新书',
      'path':'https://www.qidian.com/rank/yuepiao',
    });
    rankList.add({
      'name':'24小时热销榜',
      'path':'https://www.qidian.com/rank/hotsales',
    });
    rankList.add({
      'name':'新锐会员周点击榜',
      'path':'https://www.qidian.com/rank/newvipclick',
    });
    rankList.add({
      'name':'推荐票榜',
      'path':'https://www.qidian.com/rank/recom',
    });
    rankList.add({
      'name':'收藏榜',
      'path':'https://www.qidian.com/rank/collect',
    });
    rankList.add({
      'name':'完本榜',
      'path':'https://www.qidian.com/rank/fin',
    });
    rankList.add({
      'name':'签约作家新书榜',
      'path':'https://www.qidian.com/rank/signnewbook',
    });
    rankList.add({
      'name':'公众作家新书榜',
      'path':'https://www.qidian.com/rank/pubnewbook',
    });
    return rankList;
  }

  static getTypeList()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String typeListStr = prefs.getString("typeList");
    if(typeListStr != null){
      print("get typeList cache");
      return json.decode(typeListStr);
    }else{
      print("get typeList default");
      List typeList = [];
      typeList.add({
        'name':'全部分类',
        'chn':'-1',
      });
      typeList.add({
        'name':'玄幻',
        'chn':'21',
      });
      typeList.add({
        'name':'奇幻',
        'chn':'1',
      });
      typeList.add({
        'name':'武侠',
        'chn':'2',
      });
      typeList.add({
        'name':'仙侠',
        'chn':'22',
      });
      typeList.add({
        'name':'都市',
        'chn':'4',
      });
      typeList.add({
        'name':'现实',
        'chn':'15',
      });
      typeList.add({
        'name':'军事',
        'chn':'6',
      });
      typeList.add({
        'name':'历史',
        'chn':'5',
      });
      typeList.add({
        'name':'游戏',
        'chn':'7',
      });
      typeList.add({
        'name':'体育',
        'chn':'8',
      });
      typeList.add({
        'name':'科幻',
        'chn':'9',
      });
      typeList.add({
        'name':'灵异',
        'chn':'10',
      });
      typeList.add({
        'name':'二次元',
        'chn':'12',
      });
      return typeList;
    }
  }
  static getRankRegex()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rankRegexStr = prefs.getString("rankRegex");
    if(rankRegexStr != null){
      print('getRankRegex cache');
      return json.decode(rankRegexStr);
    }else{
      print("getRankRegex default");
      String titleRegex = r'''<div class="book-mid-info">.*?<h4><a href="//book.qidian.com/info/[\s\S]*?>(.*?)</a>''';
      String coverRegex = r'<a href="//book.qidian.com/info/.*?" target="_blank" data-eid="qd_C39" data-bid=".*?"><img src="//([\s\S]*?)"></a>';
      String introRegex = r'<p class="intro">(.*?)</p>';
      String lastRegex = r'<p class="update"><a href=".*?" target="_blank" data-eid="qd_C43" data-bid=".*?" data-cid=".*?">(.*?)</a><em>&#183;</em><span>.*?</span>';
      String lastDateRegex = r'<p class="update"><a href=".*?" target="_blank" data-eid="qd_C43" data-bid=".*?" data-cid=".*?">.*?</a><em>&#183;</em><span>(.*?)</span>';
      String authorRegex = r'<img src=".*?"><a class="name" href=".*?" target="_blank" data-eid="qd_C41">([\s\S]*?)</a><em>';
      String typeRegex = r'<div class="book-mid-info">.*?data-eid="qd_C42">(.*?)</a><em>|</em><span>$';
      String linkRegex = r'<div class="book-img-box">.*?<a href="//(.*?)" target="_blank" data-eid="qd_C39" data-bid=".*?"><img src="//.*?"></a>.*?</div>';

      Map rankRegex = {
        "titleRegex":titleRegex,
        "coverRegex":coverRegex,
        "introRegex":introRegex,
        "lastRegex":lastRegex,
        "lastDateRegex":lastDateRegex,
        "authorRegex":authorRegex,
        "typeRegex":typeRegex,
        "linkRegex":linkRegex,
      };
      return rankRegex;
    }
  }
  static getQiDianIndexRegex()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String qiDianIndexRegexStr = prefs.getString("qiDianIndexRegex");
    if(qiDianIndexRegexStr != null){
      print("getQiDianIndexRegex from cache");
      return json.decode(qiDianIndexRegexStr);
    }else{
      print("getQiDianIndexRegex from default");
      Map qiDianIndexRegex = {
        "shortIntro":r'<p class="intro">(.*?)</p>'
      };
      return qiDianIndexRegex;
    }

  }
  static getSearchRegexData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String searchDataStr = prefs.getString("searchData");
    print(searchDataStr);
    if(searchDataStr != null){
      print("getSearchRegexData from cache");
      return json.decode(searchDataStr);
    }else{
      print("getSearchRegexData from default");
      Map searchData = {};
      searchData['searchUrl'] = 'https://www.biqudu.com/searchbook.php?keyword=';
      String searchTitleRegex = r'<dl><dt><span>.*?</span><ahref=".*?">(.*?)</a></dt><dd>.*?</dd></dl>';
      String searchCoverRegex = r'<ahref=".*?"><imgsrc="(.*?)"alt=".*?"width="120"height="150"/>';
      String searchAuthorRegex = r'<dl><dt><span>(.*?)</span><ahref=".*?">.*?</a></dt><dd>.*?</dd></dl>';
      String searchLinkRegex = r'<dl><dt><span>.*?</span><ahref="(.*?)">.*?</a></dt><dd>.*?</dd></dl>';
      String searchIntroRegex = r'<dd>(.*?)</dd>';
      Map searchRegex = {
        'titleRegex':searchTitleRegex,
        'coverRegex':searchCoverRegex,
        'authorRegex':searchAuthorRegex,
        'linkRegex':searchLinkRegex,
        'introRegex':searchIntroRegex,
      };
      searchData['regex'] = searchRegex;
      searchData['domain'] = "https://www.biqudu.com/";
      return searchData;
    }
  }
  static getMenuRegexData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String menuDataStr = prefs.getString("menuData");
    if(menuDataStr!=null){
      print("getMenuRegexData from cache");
      return json.decode(menuDataStr);
    }else{
      print("getMenuRegexData from default");
      Map menuData = {};
      String menuChapterRegex = r'<dd><ahref=".*?">(.*?)</a></dd>';
      String menuLinkRegex = r'<dd><ahref="(.*?)">.*?</a></dd>';
      Map menuRegex = {
        "chapterRegex":menuChapterRegex,
        "linkRegex":menuLinkRegex,
      };
      menuData['regex'] = menuRegex;
      menuData['skip'] = 12;
      return menuData;
    }
  }
  static getReadRegexData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String readDataStr = prefs.getString("readData");
    if(readDataStr != null){
      print("getReadRegexData from cache");
      return json.decode(readDataStr);
    }else{
      print("getReadRegexData from default");
      Map readData = {};
      String readContentRegex = r'<div id="content">(.*?)</div>';
      Map readRegex = {
        "contentRegex":readContentRegex,
      };
      readData['regex'] = readRegex;
      return readData;
    }
  }
}