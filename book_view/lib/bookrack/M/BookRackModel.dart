import 'package:book_view/Global/dataHelper.dart';
import 'package:book_view/Global/XHttp.dart';
import 'package:book_view/tools/XRegexObject.dart';
import 'package:book_view/Global/XContants.dart';


typedef VoidCallback = void Function();

class BookRackModel{
  static checkBookUpdate(VoidCallback callBack)async{

      DataHelper db = await getDataHelp();
      List rackList = await db.getRackList();
      for(Map book in rackList){
        Map chapter = await db.getFirstChapter(book['bookName']);
        if(chapter!=null){
          print(chapter['menuLink']);
          Map regexData = await DefaultSetting.getMenuRegexData();
          String response = await XHttp.awaitGetWithCompleteUrl(chapter['menuLink'], {});
          response = response.replaceAll(RegExp("\r|\n|\\s"), "");
          if(response!=null){
            XRegexObject find = new XRegexObject(text: response);
            String chapterRegex = regexData['regex']['chapterRegex'];
            String linkRegex = regexData['regex']['linkRegex'];
            int skip = regexData['skip'];
            List titles = find.getListWithRegex(chapterRegex);
            List links = find.getListWithRegex(linkRegex);
            if(skip>titles.length){
              skip = titles.length;
            }

            titles = titles.sublist(skip);
            links = links.sublist(skip);
            DataHelper db = await getDataHelp();
            await db.insertChapterList(book['bookName'], titles, links, chapter['menuLink']);
          }
        }
      }
      callBack();
  }
}