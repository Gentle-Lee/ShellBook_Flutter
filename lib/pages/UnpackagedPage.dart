import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shellbook_flutter/View/BlankView.dart';
import '../View/Header.dart';
import '../database/CustomDatabase.dart';
import '../model/Order.dart';
import '../model/OrderToBook.dart';
import '../model/Book.dart';
import '../View/UnpackageItem.dart';
import '../model/OrderList.dart';
import 'package:shellbook_flutter/network.dart';
import 'dart:convert';

class UnpackagedPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new UnpackagedPageState();
  }
}

class UnpackagedPageState extends State<UnpackagedPage>{
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
    return RefreshIndicator(
      onRefresh: _refresh,
      backgroundColor: Colors.blue,
      child: Container(
        child: _list.length == 0 ? BlankView() : ListView.builder(
          itemBuilder: (context, index) {
            if (index == _list.length) {
              return _buildProgressIndicator();
            }
            return UnpackageItem(index,_list[index],db,confirmfunc: confirmOrder,);
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
      List<Map> mList = await db.selectUnpackOrder();
      _list = OrderList.fromJson(mList).list;
      setState(() {
        isPerformingRequest = false;
      });
    }
  }
  confirmOrder(int orderId,int index){
    var params = {
      'orderId':orderId
    };
    NetWork.instance.post(NetWork.COMFIRM_ORDER,data:params )
        .then((res)async {
          var msg = JSON.decode(res.data.toString());
          print(msg);
          if(msg['msg'] == 'success'){
            Scaffold.of(context).showSnackBar(
                new SnackBar(content: new Text("确认装袋成功")));
            _list[index].packed = 1;
            await db.updateOrderPacked(_list[index]);
            if(this.mounted){
              setState(() {
                _list.removeAt(index);
                print('remove from list');
              });
            }
          }else{
            Scaffold.of(context).showSnackBar(
                new SnackBar(content: new Text("确认装袋失败,请稍后再试")));
          }
    });
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