import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reward_app/data/db/BaseDbServices.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../../res/app_constants.dart';

class DbServices extends BaseDbServices {
  DbServices._privateConstructor();

  static final DbServices instance = DbServices._privateConstructor();
  Database? database;

  Future<Database> _openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "rewardDB.db");
    return await openDatabase(dbPath, onCreate: (db, version) {
      //create all your tables here
      db.execute("create table ${AppConstants.TABLE_NAME}( "
          "${AppConstants.COLUMN_NOTE_SNO} integer primary key autoincrement ,"
          "${AppConstants.COLUMN_NOTE_TITLE} text ,"
          " ${AppConstants.COLUMN_NOTE_DESC} text)");
    }, version: 1);
  }

  @override
  Future addData() {
    // TODO: implement addData
    throw UnimplementedError();
  }

  @override
  Future deleteData() async {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<Database> getDb() async {
    return database!;
  }

  @override
  Future updateData() async {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
