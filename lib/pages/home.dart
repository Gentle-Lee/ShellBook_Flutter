import 'package:flutter/material.dart';
import 'UnpackagedPage.dart';
import 'UnfinishPage.dart';
import 'ProblemPage.dart';
import 'SearchPage.dart';
import 'AboutPage.dart';
import 'WebPage.dart';
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<StatefulWidget> _children = [
    new UnpackagedPage(),
    new UnfinishPage(),
    new ProblemPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:new Container( child:Text("贝壳淘书"),margin: const EdgeInsets.only(left: 150.0),),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search, color: Colors.white ,),
              onPressed: (){
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) {
                      return new SearchPage();
                    }
                ));
              }
          ),
          new IconButton(
              icon: new Icon(Icons.book, color: Colors.white),
              onPressed: (){
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) {
                      return new WebPage();
                    }
                ));
              }
          ),
          new IconButton(
              icon: new Icon(Icons.account_circle, color: Colors.white),
              onPressed: (){
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) {
                      return new AboutPage();
                    }
                ));
              }
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.redeem),
            title: new Text('未封装'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.remove_shopping_cart),
            title: new Text('未处理'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.feedback),
              title: Text('问题订单')
          )
        ],
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
