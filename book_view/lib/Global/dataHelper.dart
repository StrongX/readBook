import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'dart:async';

const dbName = 'test05.db';

Future<DataHelper>getDataHelp()async{
  DataHelper helper = DataHelper();
  await helper.init();
  return helper;
}

class DataHelper{
  static final DataHelper _singleton = new DataHelper._internal();
  factory DataHelper() {
    return _singleton;
  }
  DataHelper._internal();


  Database database;
  init()async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    if(database==null){
      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) {
            // When creating the db, create the table
          });
    }
    await database.execute("CREATE TABLE IF NOT EXISTS Chapter (id INTEGER PRIMARY KEY, bookName TEXT, chapterName TEXT UNIQUE, link TEXT,menuLink TEXT)");
    await database.execute("CREATE TABLE IF NOT EXISTS RackList (id INTEGER PRIMARY KEY, bookName TEXT, cover TEXT, link TEXT,author TEXT,type TEXT,lastChapter TEXT,desc TEXT,shortIntro TEXT,lastChapterDate TEXT,currentChapter TEXT,offset REAL)");
    await database.execute("CREATE TABLE IF NOT EXISTS ChapterCache (id INTEGER PRIMARY KEY, bookName TEXT, chapterName TEXT, content TEXT,link TEXT)");

  }
//  closeDataBase()async{
//    await database.close();
//  }
//  insertChapter(String bookName,String chapterName,String link)async{
//    await database.rawInsert('INSERT OR IGNORE INTO Chapter(bookName, chapterName, link) VALUES("$bookName", "$chapterName", "$link")');
//
//  }
  insertChapterList(String bookName,List chapters,List links,String menuLink)async{
    Batch batch = database.batch();
    for(int i = 0; i<chapters.length;i++){
      String chapterName = chapters[i];
      String link = links[i];
      if(!link.startsWith(RegExp("^http"))){
        link = "https://www.biqudu.com"+link;
      }
      batch.execute('INSERT OR IGNORE INTO Chapter(bookName, chapterName, link,menuLink) VALUES("$bookName", "$chapterName", "$link","$menuLink")');
    }
    await batch.commit();
  }

  insertRack(String bookName,String cover,String link,String author,String type,String lastChapter,String desc,String shortIntro,String lastChapterDate)async{
    List list = await database.rawQuery('select * from RackList where bookName = "$bookName"');
    if(list.length==0){
      await database.execute('INSERT OR IGNORE INTO RackList(bookName, cover, link,author,type,lastChapter,desc,shortIntro,lastChapterDate) VALUES("$bookName", "$cover", "$link","$author","$type","$lastChapter","$desc","$shortIntro","$lastChapterDate")');
    }else{
      print("已加入书架");
    }
  }
  deleteRack(int id)async{
    await database.rawDelete('DELETE FROM RackList WHERE id = ?', [id]);
  }
  updateCurrentChapter(String bookName,String chapterName)async{
    await database.rawUpdate(
        'UPDATE RackList SET currentChapter = "$chapterName" WHERE bookName = "$bookName"',);
  }
  updateOffset(String bookName,double offset)async{
    await database.rawUpdate(
      'UPDATE RackList SET offset = ? WHERE bookName = ?',[offset,bookName]);
  }
  getOffset(String bookName)async{
    List books = await database.rawQuery('select * from RackList where bookName = "$bookName"');
    if(books.length == 0){
      return 0.0;
    }
    Map book = await books.first;
    return book['offset'];
  }
  cacheChapter(String bookName,String chapterName,String content,String link)async{
//    var values = <String, dynamic>{
//      'bookName': bookName,
//      'chapterName': chapterName,
//      'content': content,
//    };
    List val = [bookName,chapterName,content];
//    await database.insert('ChapterCache', values,conflictAlgorithm: ConflictAlgorithm.ignore);
//    await database.execute("INSERT INTO ChapterCache(bookName,chapterName,content) select '$bookName','$chapterName','$content' where not exists (select * from ChapterCache where bookName = '$bookName' and chapterName='$chapterName')");
    List list = await database.rawQuery('select * from ChapterCache where bookName = "$bookName" and chapterName = "$chapterName"');
    if(list.length == 0){
      await database.execute("INSERT OR IGNORE INTO ChapterCache(bookName,chapterName,content) values (?,?,?)",val);
      print("插入成功");
    }else{
      print("已缓存");
    }
  }
  getChapterFromCache(String bookName,String chapterName)async{
    List list = await database.rawQuery('select * from ChapterCache where bookName = "$bookName" and chapterName = "$chapterName"');
    if(list.length == 0){
      return null;
    }else{
      return list.last;
    }
  }
  chapterIsCache(String bookName,String chapterName)async{
    List list = await database.rawQuery('select * from ChapterCache where bookName = "$bookName" and chapterName = "$chapterName"');
    if(list.length == 0){
      return false;
    }else{
      return true;
    }
  }
  getRackList()async{
    List list = await database.rawQuery('select * from RackList');
    return list;
  }
  Future<Map> getChapter(String bookName,String chapterName)async{
    List chapters = await database.rawQuery('select * from Chapter where bookName = "$bookName" and chapterName = "$chapterName"');
    return chapters.first;
  }
  Future<List> getChapterList(String bookName)async{
    List chapters = await database.rawQuery('select * from Chapter where bookName = "$bookName"');
    return chapters;
  }
  Future<Map> getNextChapter(String bookName,int id)async{
    List chapters = await database.rawQuery('select * from Chapter where bookName = "$bookName" and id>"$id" limit 1');
    if(chapters.length==0){
      return null;
    }
    return chapters.first;
  }
  Future<Map> getLastChapter(String bookName,int id)async{
    List chapters = await database.rawQuery('select * from Chapter where bookName = "$bookName" and id<"$id"');
    return chapters.last;
  }
  Future<List<Map<String, dynamic>>> getFlowChapter(String bookName,int id)async{//获取接下来的章节
    List chapters = await database.rawQuery('select * from Chapter where bookName = "$bookName" and id>"$id"');
    return chapters;
  }

  static readDataFromTable({Key key,table})async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {

        });
    String query = 'SELECT * FROM $table';
    List<Map> list = await database.rawQuery(query);
    return list;
  }
}