import 'package:flutter/material.dart';
import 'package:shellbook_flutter/View/BlankView.dart';
import '../View/Header.dart';
import 'package:shellbook_flutter/network.dart';
import 'dart:convert';
import '../database/CustomDatabase.dart ';
import '../model/SearchOrderList.dart';
import '../model/SearchOrder.dart';
import '../View/SearchPalnBookListView.dart';
class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }

}

class SearchPageState extends State<SearchPage>{
  List<SearchOrder> _list = new List();
  CustomDatabase database = new CustomDatabase();
  final TextEditingController _controller = new TextEditingController();
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
              controller: _controller,
            ),
          ),
          FlatButton(
            textColor: Colors.white,
            child: new Text("搜索",style: new TextStyle(color: Colors.white),),
            onPressed: requestList,
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
          child: _list == null || _list.length == 0 ? BlankView() : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Header(_list[index].order),
                      Divider(
                        height: 8.0,
                        color: Colors.blueGrey,
                      ),
                      SearchBookList(_list[index].mapList,database),
                      _list[index].order.lack == null ? Container() : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: const Text('订单问题 : '),
                              flex: 2,
                            ),
                            Expanded(
                              child: Text(_list[index].order.lack == null ? "无数据" : _list[index].order.lack),
                              flex: 8,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: _list == null ? 0 : _list.length,
          ),
        ),
      ),
    );
  }

  requestList(){
    print('text ='+_controller.text);
    if(_list != null && _list.length!=0){
      if(this.mounted){
        setState(() {
          _list.clear();
        });
      }
    }
    NetWork.getRes(NetWork.SEARCH_ORDER+ _controller.text)
        .then((res){
          List jsonList = JSON.decode(res.data.toString());
          print(jsonList);
          if(this.mounted){
            setState(() {
              _list = SearchOrderList.fromJson(jsonList).list;
              print('_list length = ' + _list.length.toString());
            });
          }
    });
  }



}