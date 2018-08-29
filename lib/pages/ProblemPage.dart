import 'package:flutter/material.dart';
import 'dart:async';
import '../View/ProblemListItem.dart';
import '../model/Order.dart';
import '../database/CustomDatabase.dart';
import '../model/OrderList.dart';
import '../View/BlankView.dart';

class ProblemPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProblemPageState();
  }
}

class ProblemPageState extends State<ProblemPage>{
  List<Order> _list = List();
  CustomDatabase db = new CustomDatabase();
  var curPage = 1;
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  @override
  void initState() {
    super.initState();
    _getMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      backgroundColor: Colors.blue,
      child: Container(
        child: _list.length == 0 ? BlankView() : ListView.builder(
          itemBuilder: (context, index) {
            if (index == _list.length) {
              return _buildProgressIndicator();
            }
            return ProblemListItem(_list[index],db);
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
      List<Map> mList = await db.selectProblemOrder();
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