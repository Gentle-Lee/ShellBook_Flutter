import 'package:flutter/material.dart';

import '../model/Order.dart';
import 'package:shellbook_flutter/network.dart';
import 'package:intl/intl.dart';
class Header extends StatefulWidget{
  Header(this.order);
  final Order order;

  @override
  State<StatefulWidget> createState() {
    return HeaderState();
  }

}

class HeaderState extends State<Header>{

  Order order;
  String status = "";
  String headimg = "";
  @override
  void initState() {
    super.initState();
    order = widget.order;
    if(order.headimg == null){
      headimg = NetWork.USER_URL_PREFIX +'/images/user/default.png';
    }
    else if(!order.headimg.contains('http')){
      headimg = NetWork.USER_URL_PREFIX + order.headimg;
    }else{
      headimg = order.headimg;
    }
    if(order.deliveryStatus == 0 && order.deliveryMethod == 1){
      status = "未配送";
    }else{
      status = "未自取";
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage.assetNetwork(
        width: 40.0,
        height: 40.0,
        placeholder: 'images/icon_shellbook.png',
        image: headimg,
      ),
      title: Row(
        children: <Widget>[
          new Text(order.nickname == null ? "null" : order.nickname),
          Text('('+order.dorm + order.room +')')
        ],
      ),
      subtitle: new Text(DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(order.createDatetime))),
      trailing: new Text(status),
    );
  }

}
