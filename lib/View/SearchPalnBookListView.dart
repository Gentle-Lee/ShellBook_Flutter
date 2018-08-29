import 'package:flutter/material.dart';
import 'package:shellbook_flutter/model/Book.dart';
import '../model/OrderToBook.dart';
import '../database/CustomDatabase.dart ';
import '../View/PlainBookListVIew.dart';
import '../model/OrderBook.dart';
class SearchBookList extends StatefulWidget{
  List<OrderToBook> orderToBookList;
  CustomDatabase database;
  SearchBookList(this.orderToBookList,this.database);
  @override
  State<StatefulWidget> createState() {
    return SearchBookListState();
  }

}
class SearchBookListState extends State<SearchBookList>{
  List<OrderToBook> orderToBookList;
  List<OrderBook> list;
  CustomDatabase database;
  @override
  void initState() {
    orderToBookList = widget.orderToBookList;
    database = widget.database;
    loadOrderBook();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PlainBookList(list);
  }

  loadOrderBook()async {
    List<OrderBook> mList = new List();
    for(int i = 0 ; i < orderToBookList.length; i ++){
      List item = await database.selectBookByBookId(orderToBookList[i].bookId);
      Book book = Book.fromJson(item[0]);
      mList.add(new OrderBook(book: book,amount: orderToBookList[i].amount));
    }
    if(this.mounted){
      setState(() {
        list = mList;
      });
    }
  }

}
