import 'dart:async';

import 'package:flutter/material.dart';
import '../model/Order.dart';
import '../database/CustomDatabase.dart';
import '../View/Header.dart';
import '../View/PlainBookListVIew.dart';
import '../model/OrderBook.dart';
import '../model/BookList.dart';
class UnhandledListItem extends StatefulWidget{
  Order order;
  CustomDatabase database;
  UnhandledListItem(this.order,this.database);
  @override
  State<StatefulWidget> createState() {
    return new UnhandledListItemState();
  }
}

class UnhandledListItemState extends State<UnhandledListItem>{
  List<OrderBook> list;
  Order order;
  CustomDatabase database;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.order = widget.order;
    this.database = widget.database;
    loadBookList().then((data){
      if(this.mounted){
        setState(() {
          list = data;
        });
      }
    });
  }
  Future<List<OrderBook>> loadBookList()async{
    list = BookList.fromJson(await database.selectFromBookWithOrderId(order.id)).list;
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Header(order),
            Divider(
              height: 8.0,
              color: Colors.blueGrey,
            ),
            PlainBookList(list)
          ],
        ),
      ),
    );
  }

}