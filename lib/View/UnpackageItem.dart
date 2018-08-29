import 'dart:async';

import 'package:flutter/material.dart';
import '../model/Order.dart';
import './Header.dart';
import '../database/CustomDatabase.dart';
import './BookListView.dart';
import '../model/BookList.dart';
import '../model/OrderBook.dart';
import 'package:url_launcher/url_launcher.dart';

class UnpackageItem extends StatefulWidget{
  int index;
  Order order;
  CustomDatabase database;
  var confirmfunc;
  UnpackageItem(this.index,this.order,this.database,{this.confirmfunc});
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
    print(order.id);
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
    List<OrderBook> list = BookList.fromJson(await database.selectFromUnpackedBook(order.id)).list;
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
                    onPressed: launchTel,
                  ),
                  flex: 6,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: new Text("finish",style: new TextStyle(color: Colors.white),),
                      onPressed: pressConfirm,
                    ),
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

  launchTel()async{
    String url = 'tel:'+ order.phone;
    print(url);
    print(order.phone);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text("无法打开电话界面")));
    }
  }

  pressConfirm(){
    widget.confirmfunc(order.id,widget.index);
  }



}