import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../widgets/package_item_widget.dart';

class UnpackagedPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new UnpackagedPageState();
  }
}

class UnpackagedPageState extends State<UnpackagedPage>{
  var listData;
  var testData = [1,2,3,4,5];
  var slideData;
  var curPage = 1;
  var listTotalSize = 0;
  ScrollController _controller = new ScrollController();
  @override
  void initState() {
    super.initState();
    getListData();
  }
  Future<Null> _pullToRefresh() async {
    curPage = 1;
//    getNewsList(false);
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ListView.builder(
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
                            child: Icon(Icons.book),
                          flex: 2,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text('bookName'),
                              Text('bookAuthor'),
                              Text('bookVersion'),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          flex: 6,
                        ),
                        Expanded(
                          child: Center(child: Text('test num')),
                          flex: 2,
                        )
                      ]
                    );
                  },
                  itemCount: testData[index]*2 ,
                  shrinkWrap: true, // todo comment this out and check the result
                  physics: ClampingScrollPhysics(), // todo comment this out and check the result
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Contact'),
                      ),
                      onPressed: () {},
                    ),
                    flex: 6,
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: new Text("finish",style: new TextStyle(color: Colors.white),),
                      onPressed: () {},
                    ),
                    flex: 4,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              )
            ],
          ),
        ),
      );
    },
    itemCount: testData.length,
    ),
    );
  }

  getListData(){
    List list = new List();
    for(var i = 0 ; i < 9;i++){
      var obj = {
        'userName': 'test ' + i.toString(),
        'userAddress': 'testAddress' + i.toString(),
        'userImg': 'https://pic3.zhimg.com/50/2b8be8010409012e7cdd764e1befc4d1_s.jpg',
        'orderTime': new DateTime.now().toString(),
        'books': [
          {
            'bookImg': 'https://pic3.zhimg.com/50/2b8be8010409012e7cdd764e1befc4d1_s.jpg',
            'bookName': 'testBook' + i.toString(),
            'bookAuthor': 'test Author' + i.toString(),
            'bookVersion': 'bookVersion+ i.toString() ',
            'bookNum' : i.toString()
          },
          {
            'bookImg': 'https://pic3.zhimg.com/50/2b8be8010409012e7cdd764e1befc4d1_s.jpg',
            'bookName': 'testBook' + i.toString(),
            'bookAuthor': 'test Author' + i.toString(),
            'bookVersion': 'bookVersion+ i.toString() ',
            'bookNum' : i.toString()
          },
          {
            'bookImg': 'https://pic3.zhimg.com/50/2b8be8010409012e7cdd764e1befc4d1_s.jpg',
            'bookName': 'testBook' + i.toString(),
            'bookAuthor': 'test Author' + i.toString(),
            'bookVersion': 'bookVersion+ i.toString() ',
            'bookNum' : i.toString()
          },
        ]
      };
      list.add(obj);
    }
    this.listData = list;
  }
}