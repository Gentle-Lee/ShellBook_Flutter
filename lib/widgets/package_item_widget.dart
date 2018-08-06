import 'package:flutter/material.dart';

class PackageItemWidget extends StatelessWidget{
//  var list;
//  PackageItemWidget(list){
//    this.list = list;
//  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CustomScrollView(
      slivers: [
        new SliverToBoxAdapter(
          child: new Container(height: 100.0, color: Colors.blueAccent),
        ),
        new SliverList(
          delegate: new SliverChildListDelegate(
            new List<Widget>.generate(10, (int index) {
              return new Text(
                'Item $index',
                style: new TextStyle(fontSize: 42.0),
              );
            }),
          ),
        ),
        new SliverToBoxAdapter(
          child: new Container(height: 100.0, color: Colors.tealAccent),
        ),
      ],
    );
  }

//  Widget renderRow(i){
//    if(i.isOdd){
//      return new Divider(height: 1.0);
//    }
//    return new Column(
//      children: <Widget>[
//        new ListTile(
//          leading: new Container(
//            width: 300.0,
//            height: 400.0,
//            decoration: new BoxDecoration(
//              shape: BoxShape.rectangle,
//              color: const Color(0xFFECECEC),
//              image: new DecorationImage(
//                  image: new NetworkImage(list['books'][i].bookImg), fit: BoxFit.cover),
//              border: new Border.all(
//                color: const Color(0xFFECECEC),
//                width: 2.0,
//              ),
//            ),
//          ),
//          title: list['books'][i].bookName,
//          subtitle: new Column(
//            children: <Widget>[
//              new Text(list['books'][i].bookAuthor),
//              new Text(list['books'][i].bookVersion)
//            ],
//          ),
//          trailing: new Text(list['books'][i].bookNum + '本'),
//        )
//      ],
//    );
//  }
}