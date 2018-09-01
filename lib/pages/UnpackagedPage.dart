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
  bool flag = true;
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  @override
  initState() {
    super.initState();

    loadOrder();
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
            return Container(
                child: UnpackageItem(index,_list[index],db,confirmfunc: confirmOrder)
            );
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
    if(flag){
      await NetWork.syncDatabase();
      await loadOrder();
    }else{
      await loadOrder();
      setState(() {
        flag = true;
      });
    }

    return;
  }

  @override
  void didUpdateWidget(UnpackagedPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  loadOrder()async {
    List<Map> mList = await db.selectUnpackOrder();
    setState(() {
      _list = OrderList.fromJson(mList).list;
    });
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      setState(() {
        isPerformingRequest = false;
      });
    }
  }
  confirmOrder(int orderId,int index)async {
    setState(() {
      flag = false;
    });
    var params = {
      'orderId':orderId
    };
    await NetWork.instance.post(NetWork.COMFIRM_ORDER,data:params )
        .then((res)async {
          var msg = const JsonCodec().decode(res.data.toString());
          print(msg);
          if(msg['msg'] == 'success'){
            _list[index].packed = 1;
            db.updateOrderPacked(_list[index]);
            setState(() {
              print( _list[index].id.toString() + 'remove from list');
              _list.removeAt(index);
              _refresh();
            });
            Scaffold.of(context).showSnackBar(
                new SnackBar(content: new Text("确认装袋成功")));
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