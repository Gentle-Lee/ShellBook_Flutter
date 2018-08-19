import 'dart:async';
import 'package:flutter/material.dart';
import '../View/Header.dart';
import '../database/CustomDatabase.dart';
import '../model/Order.dart';
import '../model/OrderToBook.dart';
import '../model/Book.dart';
import '../View/UnpackageItem.dart';
import 'package:http/http.dart' as http;
class UnpackagedPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new UnpackagedPageState();
  }
}

class UnpackagedPageState extends State<UnpackagedPage>{
  Order order;
  List<Order> list;
  CustomDatabase db;
  List<OrderToBook> orderItem;
  var curPage = 1;
  ScrollController _controller = new ScrollController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ListView.builder(
        itemBuilder: (context, index) {
          return UnpackageItem(order,db);
        },
        itemCount: list.length,
      ),
    );
  }

}