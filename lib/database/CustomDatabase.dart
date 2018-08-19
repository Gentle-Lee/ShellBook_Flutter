import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'BookSQL.dart';
import 'OrderSQL.dart';
import 'OrderToBookSQL.dart';
import '../model/Order.dart';
import '../model/OrderToBook.dart';
import '../model/Book.dart';

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


  Future<int> addOrderToMap(OrderToBook orderToBook) async {
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
      print("book added $res");
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
    print("book updated $res");
    return res;
  }

  Future closeDb() async {
    var dbClient = await db;
    dbClient.close();
  }
}