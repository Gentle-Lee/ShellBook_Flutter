import 'dart:async';

import 'package:flutter/material.dart';
import '../model/Order.dart';
import './Header.dart';
import '../database/CustomDatabase.dart';
import './BookListView.dart';
import '../model/BookList.dart';
import '../model/OrderBook.dart';
class UnpackageItem extends StatefulWidget{
  Order order;
  CustomDatabase database;
  UnpackageItem(this.order,this.database);
  @override
  State<StatefulWidget> createState() {
    return UnpackageItemStage();
  }

}

class UnpackageItemStage extends State<UnpackageItem>{
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
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            Header(order),
            Divider(
              height: 8.0,
              color: Colors.blueGrey,
            ),
            BookListView(bookList),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Contact'),
                    ),
                    onPressed: () {},
                  ),
                  flex: 6,
                ),
                Expanded(
                  child: MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: new Text("finish",style: new TextStyle(color: Colors.white),),
                    onPressed: () {},
                  ),
                  flex: 4,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            )
          ],
        ),
      ),
    );
  }

}