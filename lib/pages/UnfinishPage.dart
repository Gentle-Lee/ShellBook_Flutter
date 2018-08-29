import 'package:flutter/material.dart';
import 'dart:async';
import '../View/UnhandledListItemView.dart';
import '../database/CustomDatabase.dart';
import '../model/Order.dart';
import '../model/OrderList.dart';
import '../View/BlankView.dart';
class UnfinishPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return UnfinishPageState();
  }

}

class UnfinishPageState extends State<UnfinishPage> with SingleTickerProviderStateMixin{
  List<Order> _list = List();
  CustomDatabase db = new CustomDatabase();
  TabController _tabController;
  var curPage = 1;
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  @override
  void initState() {
    super.initState();
    loadOrder();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(loadOrder);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//        _getMoreData();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          unhandledPage(1),
          unhandledPage(2),
          unhandledPage(3),
        ],
        controller: _tabController,
      ),
    );
  }

  Widget unhandledPage(int deliveryMethod){
    return new RefreshIndicator(
        onRefresh: _refresh,
        backgroundColor: Colors.blue,
        child: Container(
          child: _list.length == 0 ? BlankView() : ListView.builder(
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
    _tabController.dispose();
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
  
  loadOrder()async {
    List<Map> mList;
    switch((_tabController.index)){
      case 0 :
        mList = await db.selectUnfinishedOrder();
        break;
      case 1:
        mList = await db.selectOrderByDeliveryMethod(0);
        break;
      case 2:
        mList = await  db.selectOrderByDeliveryMethod(1);
        break;
    }
    if(this.mounted){
      setState(() {
        _list =  OrderList.fromJson(mList).list;
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