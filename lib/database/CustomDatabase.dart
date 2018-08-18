import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'BookSQL.dart';
import 'OrderSQL.dart';
import 'OrderToBookSQL.dart';

import 'dart:async';
import 'dart:io';



class CustomDatabase{
  static final CustomDatabase _instance = CustomDatabase._internal();
  factory CustomDatabase()=>_instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  CustomDatabase._internal();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(BookSQL.create);
    await db.execute(OrderSQL.create);
    await db.execute(OrderToBookSQL.create);
    print("Database was Created!");
  }



}