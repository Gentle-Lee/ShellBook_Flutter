import 'package:flutter/material.dart';
import 'dart:async';
import '../View/UnhandledListItemView.dart';
import '../database/CustomDatabase.dart';
import '../model/Order.dart';
import '../model/OrderList.dart';

class UnfinishPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return UnfinishPageState();
  }

}

class UnfinishPageState extends State<UnfinishPage>{
  List<Order> _list = List();
  CustomDatabase db = new CustomDatabase();
  var curPage = 1;
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  @override
  void initState() {
    super.initState();
    print("init state");
    _getMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("全部",style: new TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("未配送",style: new TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("未自取",style: new TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            unhandledPage(0),
            unhandledPage(0),
            unhandledPage(0),
          ],
        ),
      ),
    );
  }

  Widget unhandledPage(int deliverySatus){
    return RefreshIndicator(
        onRefresh: _refresh,
        backgroundColor: Colors.blue,
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == _list.length) {
                return _buildProgressIndicator();
              }
              return UnhandledListItem(_list[index],db);
            },
            itemCount: _list == null ? 0 : _list.length,
            controller: _scrollController,
          ),
        ),
      );
  }

  Future<Null> _refresh() async {
    _list.clear();
//    await _loadFirstListData();
    return;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<Map> mList = await db.selectFromOrder();
      _list = OrderList.fromJson(mList).list;
      setState(() {
        isPerformingRequest = false;
      });
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

}