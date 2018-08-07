import 'package:flutter/material.dart';
import 'dart:async';

class UnfinishPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return UnfinishPageState();
  }

}

class UnfinishPageState extends State<UnfinishPage>{
  var listData;
  var testData = [1,2,3,4,5];
  var slideData;
  var curPage = 1;
  var listTotalSize = 0;
  ScrollController _controller = new ScrollController();
  @override
  void initState() {
    super.initState();
  }
  Future<Null> _pullToRefresh() async {
    curPage = 1;
//    getNewsList(false);
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new MaterialButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  child: new Text("all"),
                  onPressed: (){
                  },
                  splashColor: Colors.lightBlueAccent,
                ),
                new MaterialButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  child: new Text("undeliver"),
                  onPressed: (){
                  },
                  splashColor: Colors.lightBlueAccent,
                ),
                new MaterialButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  child: new Text("all"),
                  onPressed: (){
                  },
                  splashColor: Colors.lightBlueAccent,
                ),
              ],
            ),
          ),
          SizedBox(
            height:530.0,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: new Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFECECEC),
                              image: new DecorationImage(
                                  image: new NetworkImage('https://csdnimg.cn/pubfooter/images/csdn_cs_qr.png'), fit: BoxFit.cover),
                              border: new Border.all(
                                color: const Color(0xFFECECEC),
                                width: 2.0,
                              ),
                            ),
                          ),
                          title: new Text('username'),
                          subtitle: new Text('orderTime'),
                          trailing: new Text('unPackaged'),
                        ),
                        Divider(
                          height: 8.0,
                          color: Colors.blueGrey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              if(index.isOdd )
                                return Divider(height: 4.0,);
                              return Row(
                                  mainAxisSize:MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text('bookname'),
                                      flex: 8,
                                    ),
                                    Expanded(
                                      child: Text('2t' + '本'),
                                      flex: 2,
                                    ),
                                  ]
                              );
                            },
                            itemCount: testData[index]*2 ,
                            shrinkWrap: true, // todo comment this out and check the result
                            physics: ClampingScrollPhysics(), // todo comment this out and check the result
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: testData.length,
            ),
          ),
        ],
      ),
    );
  }

}