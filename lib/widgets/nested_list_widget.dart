import 'package:flutter/material.dart';


class NestedListWidget extends StatefulWidget {
  final String title;
  Widget header;
  Widget nestedItem;
  Widget bottom;
  List list;
  NestedListWidget(Widget _header,Widget _nestedItem,Widget _bottom,{Key key, this.title}) : super(key: key){
    header = _header;
    nestedItem = _nestedItem;
    bottom = _bottom;
  }

  @override
  NestedListWidgetState createState() => new NestedListWidgetState();
}

class NestedListWidgetState extends State<NestedListWidget> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: <Widget>[
                widget.header ,
                ListView.builder(
                  itemBuilder: (context, index) {
                    return widget.nestedItem;
                  },
                  itemCount: 4,
                  shrinkWrap: true, // todo comment this out and check the result
                  physics: ClampingScrollPhysics(), // todo comment this out and check the result
                ),
                widget.bottom
              ],
            ),
          );
        },
        itemCount: 9,
      ),
    );
  }
}
