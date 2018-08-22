import 'package:book_view/Global/dataHelper.dart';
import 'package:book_view/Global/XHttp.dart';

class CacheHelper{
  static cacheBookAuto(bookName,currentChapter)async{
    DataHelper db = await getDataHelp();
    Map chapter = await db.getChapter(bookName, currentChapter);
    List chapters = await db.getFlowChapter(bookName, chapter['id']);
    for(int i = 0;i<10;i++){
      if(chapters.length>i){
        Map chapter = chapters[i];
        if(await db.chapterIsCache(bookName, chapter['chapterName'])){
        }else{
          XHttp.getWithCompleteUrl(chapter['link'], {}, (String response)async {
            response = response.replaceAll(RegExp("\r|\n"), "");
            DataHelper db = await getDataHelp();
            await db.cacheChapter(chapter['bookName'], chapter['chapterName'], response,chapter['link']);
          });
        }


      }
    }
  }
  static getChapterContent(String bookName,String chapterName,String link,void callBack(String content))async{
    DataHelper db = await getDataHelp();
    Map chapter = await db.getChapterFromCache(bookName, chapterName);
    if(chapter!=null){
      print('get cache');
      callBack(chapter['content']);
    }else{
      print('request chapter content');
      await XHttp.getWithCompleteUrl(link, {}, (String response)async {
        response = response.replaceAll(RegExp("\r|\n"), "");
        DataHelper db = await getDataHelp();
        await db.cacheChapter(bookName, chapterName, response,link);
        callBack(response);
      });
    }

  }
}