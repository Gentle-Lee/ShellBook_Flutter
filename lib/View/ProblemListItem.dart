import 'dart:async';

import 'package:flutter/material.dart';
import '../model/Order.dart';
import '../database/CustomDatabase.dart';
import '../View/Header.dart';
import '../model/BookList.dart';
import '../model/OrderBook.dart';
import '../View/PlainBookListVIew.dart';

class ProblemListItem extends StatefulWidget{
  Order order;
  CustomDatabase database;
  ProblemListItem(this.order,this.database);
  @override
  State<StatefulWidget> createState() {
    return ProblemListItemState();
  }

}

class ProblemListItemState extends State<ProblemListItem>{

  Order order;
  CustomDatabase database;
  List<OrderBook> bookList;
  @override
  void initState() {
    order = widget.order;
    database = widget.database;
    loadBooksList().then((data){
      if(this.mounted){
        setState(() {
          bookList = data;
        });
      }
    });
    super.initState();
  }
  Future<List<OrderBook>> loadBooksList()async {
    List<OrderBook> list = BookList.fromJson(await database.selectFromBookWithOrderId(order.id)).list;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            Header(order),
            Divider(
              height: 8.0,
              color: Colors.blueGrey,
            ),
            PlainBookList(bookList),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: const Text('订单问题 : '),
                    flex: 2,
                  ),
                  Expanded(
                    child: Text(order.lack == null ? "无数据" : order.lack),
                    flex: 8,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}