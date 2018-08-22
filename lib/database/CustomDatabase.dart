import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'BookSQL.dart';
import 'OrderSQL.dart';
import 'OrderToBookSQL.dart';
import '../model/Order.dart';
import '../model/OrderToBook.dart';
import '../model/Book.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:shared_preferences/shared_preferences.dart';




class CustomDatabase{
  static final CustomDatabase _instance = CustomDatabase._internal();
  factory CustomDatabase()=>_instance;
  static Database _db;
  var lock = Lock();

  Future<Database> get db async {
    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, "shellbook.db");
          var file = new File(path);

          // check if file exists
          if (!await file.exists()) {
            // Copy from asset
            ByteData data = await rootBundle.load(join("assets", "main.db"));
            List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          // open the database
          _db = await openDatabase(path,readOnly: false);
        }
      });
    }

    return _db;
  }

  CustomDatabase._internal();


  void _onCreate(Database db, int version) async {
    await db.execute(OrderSQL.create);
    await db.execute(BookSQL.create);
    await db.execute(OrderToBookSQL.create);
    print("Database was Created!");
  }


  Future<int> addOrderToBook(OrderToBook orderToBook) async {
    var dbClient = await db;
    try {
      int res = await dbClient.insert("bk_orderToBook", orderToBook.toJson());
      print("orderToBook added $res");
      return res;
    } catch (e) {
      int res = await updateOrderToBook(orderToBook);
      return res;
    }
  }

  Future<int> updateOrderToBook(OrderToBook orderToBook) async {
    var dbClient = await db;
    int res = await dbClient.update("bk_orderToBook", orderToBook.toJson(),
        where: "id = ?", whereArgs: [orderToBook.id]);
    print("orderToBook updated $res");
    return res;
  }

  Future<int> addOrder(Order order) async {
    var dbClient = await db;
    try {
      int res = await dbClient.insert("bk_order", order.toJson());
      print("order added $res");
      return res;
    } catch (e) {
      int res = await updateOrder(order);
      print("update order $res ");
      return res;
    }
  }

  Future<int> updateOrder(Order order) async {
    var dbClient = await db;
    int res = await dbClient.update("bk_order", order.toJson(),
        where: "id = ?", whereArgs: [order.id]);
    print("order updated $res");
    return res;
  }

  Future<int> addBook(Book book) async {
    var dbClient = await db;
    try {
      int res = await dbClient.insert("bk_book", book.toJson());
      print(res);
      return res;
    } catch (e) {
      int res = await updateBook(book);
      return res;
    }
  }

  Future<int> updateBook(Book book) async {
    var dbClient = await db;
    int res = await dbClient.update("bk_book", book.toJson(),
        where: "id = ?", whereArgs: [book.id]);
//    print("book updated $res");
    return res;
  }

  Future<List<Map>> selectFromOrder() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM bk_order');
    return list;
  }

  Future<List<Map>> selectFromBook() async {
    var dbClient = await db;
    List<Map> num = await dbClient.rawQuery('SELECT * FROM bk_book');
    return num;
  }

  Future<List<Map>> selectFromBookWithOrderId(int id) async {
    var dbClient = await db;
    List<Map> num = await dbClient.rawQuery('SELECT * FROM bk_book as A,bk_orderToBook as B where A.id = ? and A.id = B.orderId',[id]);
    return num;
  }

  Future closeDb() async {
    var dbClient = await db;
    dbClient.close();
  }
}