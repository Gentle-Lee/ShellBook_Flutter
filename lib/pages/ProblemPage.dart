import 'package:flutter/material.dart';
import 'dart:async';
import '../View/ProblemListItem.dart';
import '../model/Order.dart';
import '../database/CustomDatabase.dart';
import '../model/OrderList.dart';
import '../View/BlankView.dart';
import 'dart:convert';
import 'package:shellbook_flutter/network.dart';
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
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//        _getMoreData();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      backgroundColor: Colors.white,
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
    setState(() {
      _list.clear();
    });
    await getUnFinishOrder();
    await NetWork.syncDatabase();
    await loadOrders();
    return;
  }

  getUnFinishOrder()async {
    List list = await db.selectUnfinishedOrder();
    List orderIdList = new List();
    list.forEach((item)=>orderIdList.add({'id':item['id']}));
    print(orderIdList);
    print(JSON.encode(orderIdList));
    var params = {
      'orderList':orderIdList
    };
    print(params);
    NetWork.instance.post(NetWork.SYNC_FINISHED_ORDER,data: params).then((res)async {
      print(res.data.toString());
      List jsonA = JSON.decode(res.data.toString());
      for(int i = 0 ; i < jsonA.length;i++){
        Order order =Order.fromJson(jsonA[i]);
        await db.updateOrder(order);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  loadOrders()async {
    List<Map> mList = await db.selectProblemOrder();
    _list = OrderList.fromJson(mList).list;
  }
  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
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