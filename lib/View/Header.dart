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

  @override
  void initState() {
    super.initState();
    order = widget.order;
  }


  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(
          width: 20.0,
          height: 20.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFECECEC),
            image: new DecorationImage(
                image: new NetworkImage("http://beikebook.com" + order.headimg), fit: BoxFit.cover),
            border: new Border.all(
              color: const Color(0xFFECECEC),
              width: 2.0,
            ),
          ),
        ),
        new Column(
          children: <Widget>[
            new Text(order.nickName + '(' + order.dorm + order.room +')'),
            new Text(order.createDatetime)
          ],
        )
      ],
    );
  }

}
