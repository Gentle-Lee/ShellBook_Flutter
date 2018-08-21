import 'dart:async';
import 'package:flutter/material.dart';
import '../View/Header.dart';
import '../database/CustomDatabase.dart';
import '../model/Order.dart';
import '../model/OrderToBook.dart';
import '../model/Book.dart';
import '../View/UnpackageItem.dart';
import 'package:http/http.dart' as http;
class UnpackagedPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new UnpackagedPageState();
  }
}

class UnpackagedPageState extends State<UnpackagedPage>{
  List<Order> _list;
  CustomDatabase db;
  var curPage = 1;
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  @override
  void initState() {
    super.initState();
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
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == _list.length) {
            return _buildProgressIndicator();
          }
          return UnpackageItem(_list[index],db);
        },
        itemCount: _list.length,
        controller: _scrollController,
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
//      List<int> newEntries = await fakeRequest(items.length, items.length + 10);
      setState(() {
//        items.addAll(newEntries);
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