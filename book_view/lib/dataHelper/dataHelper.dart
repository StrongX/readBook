import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'dart:async';

const dbName = 'test5.db';

Future<DataHelper>getDataHelp()async{
  DataHelper helper = DataHelper();
  await helper.init();
  return helper;
}

class DataHelper{
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
    await database.execute("CREATE TABLE IF NOT EXISTS Chapter (id INTEGER PRIMARY KEY, bookName TEXT, chapterName TEXT, link TEXT)");
    await database.execute("CREATE TABLE IF NOT EXISTS RackList (id INTEGER PRIMARY KEY, bookName TEXT, cover TEXT, link TEXT,author TEXT,type TEXT,lastChapter TEXT,desc TEXT,shortIntro TEXT,lastChapterDate TEXT,currentChapter TEXT)");

  }
  closeDataBase()async{
    await database.close();
  }
  insertChapter(String bookName,String chapterName,String link)async{
    await database.execute('INSERT OR IGNORE INTO Chapter(bookName, chapterName, link) VALUES("$bookName", "$chapterName", "$link")');
  }
  insertRack(String bookName,String cover,String link,String author,String type,String lastChapter,String desc,String shortIntro,String lastChapterDate)async{
    List list = await database.rawQuery('select * from RackList where bookName = "$bookName"');
    if(list.length==0){
      await database.execute('INSERT OR IGNORE INTO RackList(bookName, cover, link,author,type,lastChapter,desc,shortIntro,lastChapterDate) VALUES("$bookName", "$cover", "$link","$author","$type","$lastChapter","$desc","$shortIntro","$lastChapterDate")');
    }else{
      print("已加入书架");
    }
  }
  updateCurrentChapter(String bookName,String chapterName)async{
    var result = await database.rawUpdate(
        'UPDATE RackList SET currentChapter = "$chapterName" WHERE bookName = "$bookName"',);
    print(result);
  }
  getRackList()async{
    List list = await database.rawQuery('select * from RackList');
    return list;
  }
  Future<List> getChapter(String bookName,String chapterName)async{
    return await database.rawQuery('select * from Chapter where bookName = "$bookName" and chapterName = "$chapterName"');
  }
  Future<List> getNextChapter(String bookName,int id)async{
    return await database.rawQuery('select * from Chapter where bookName = "$bookName" and id>"$id" limit 1');
  }
  Future<List> getLastChapter(String bookName,int id)async{
    return await database.rawQuery('select * from Chapter where bookName = "$bookName" and id<"$id" limit 1');
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