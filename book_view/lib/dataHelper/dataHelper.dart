import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'dart:async';

const dbName = 'test3.db';

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
    await database.execute(
        "CREATE TABLE IF NOT EXISTS Chapter (id INTEGER PRIMARY KEY, bookName TEXT, chapterName TEXT, link TEXT)");
  }
  closeDataBase()async{
    await database.close();
  }
  insertChapter(String bookName,String chapterName,String link)async{
    await database.execute('INSERT OR IGNORE INTO Chapter(bookName, chapterName, link) VALUES("$bookName", "$chapterName", "$link")');
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