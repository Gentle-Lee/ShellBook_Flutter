import 'package:flutter/material.dart';


class HeaderWidget extends StatelessWidget{
  var userImg;
  var userName;
  var userAddress;
  var orderTime;
  HeaderWidget(img,name,address,time){
    userImg = img;
    userName = name;
    userAddress = address;
    orderTime = time;
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
                image: new NetworkImage(userImg), fit: BoxFit.cover),
            border: new Border.all(
              color: const Color(0xFFECECEC),
              width: 2.0,
            ),
          ),
        ),
        new Column(
          children: <Widget>[
            new Text(userName + '(' + userAddress +')'),
            new Text(orderTime)
          ],
        )
      ],
    );
  }

}