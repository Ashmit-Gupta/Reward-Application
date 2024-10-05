import 'package:sqflite/sqflite.dart';

abstract class BaseDbServices {
  Future<Database> getDb();
  Future<dynamic> addData();
  Future<dynamic> updateData();
  Future<dynamic> deleteData();
}
