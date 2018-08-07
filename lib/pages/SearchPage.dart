import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }

}

class SearchPageState extends State<SearchPage>{

  Widget searchInput() {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
            child: new FlatButton.icon(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: new Icon(Icons.arrow_back, color:Colors.white),
              label: new Text(""),
            ),
            width: 60.0,
          ),
          new Expanded(
            child: new TextField(
              autofocus: true,
              decoration: new InputDecoration.collapsed(
                  hintText: "输入手机号码/宿舍/微信名",
                  hintStyle: new TextStyle(color: Colors.white)
              ),
            ),
          )
        ],
      ),
      decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
          color: Colors.blueGrey
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: searchInput(),
        ),
      ),
    );
  }

}