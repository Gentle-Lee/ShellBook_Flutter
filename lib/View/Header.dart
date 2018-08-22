import 'package:flutter/material.dart';

import '../model/Order.dart';

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
  @override
  void initState() {
    super.initState();
    order = widget.order;
    if(order.deliveryStatus == 0){
      status = "";
    }else{
      status = "unpackaged";
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: new Container(
        width: 20.0,
        height: 20.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFECECEC),
          image: new DecorationImage(
              image: new NetworkImage(order.headimg), fit: BoxFit.cover),
          border: new Border.all(
            color: const Color(0xFFECECEC),
            width: 2.0,
          ),
        ),
      ),
      title: new Text(order.nickname),
      subtitle: new Text(order.createDatetime),
      trailing: new Text(status),
    );
  }

}
