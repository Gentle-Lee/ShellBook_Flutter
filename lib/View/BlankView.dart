import 'package:flutter/material.dart';

class BlankView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          '暂无数据',
        style: new TextStyle(
          color: Colors.blueGrey
        ),
      ),
    );
  }

}
