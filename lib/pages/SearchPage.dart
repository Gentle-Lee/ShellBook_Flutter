import 'package:flutter/material.dart';
import '../model/Order.dart';
import '../View/Header.dart';
import '../View/PlainBookListVIew.dart';
import '../model/OrderBook.dart';
class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }

}

class SearchPageState extends State<SearchPage>{
  List<Order> _list;
  List<OrderBook> orderBookList;
  Widget searchInput() {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
            child: new FlatButton.icon(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: new Icon(Icons.arrow_back, color:Colors.white),
              label: new Text(""),
            ),
            width: 60.0,
          ),
          new Expanded(
            child: new TextField(
              autofocus: true,
              decoration: new InputDecoration.collapsed(
                  hintText: "输入手机号码/宿舍/微信名",
                  hintStyle: new TextStyle(color: Colors.white)
              ),
              onSubmitted: requestList(),
            ),
          )
        ],
      ),
      decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
          color: Colors.blueGrey
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: searchInput(),
        ),
        body: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Header(_list[index]),
                  PlainBookList(orderBookList),
                  _list[index].lack == null ? Container() : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: const Text('订单问题 : '),
                          flex: 2,
                        ),
                        Expanded(
                          child: Text(_list[index].lack == null ? "无数据" : _list[index].lack),
                          flex: 8,
                        )
                      ],
                    ),
                  )
                ],
              );
            },
            itemCount: _list == null ? 0 : _list.length,
          ),
        ),
      ),
    );
  }

  requestList(){}

}