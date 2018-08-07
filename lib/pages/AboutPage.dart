import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AboutPageState();
  }
}

class AboutPageState extends State<AboutPage>{

  Widget _buildHeader(){
    return Stack(
      children: <Widget>[
        Container(
          child: Image.asset('images/user_background.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.asset('images/icon_shellbook.png'),
                  width: 80.0,
                  height: 80.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('读者书店'),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    'version 1.0',
                    style: TextStyle(color: Colors.white ),
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('返回订单'),
          leading: FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )
          ),
        ),
        body: new Column(
          children: <Widget>[
            _buildHeader(),
            MaterialButton(
              minWidth: 300.0,
              height: 40.0,
              child: Text(
                  'log out',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue, onPressed: () {},
            )
          ],
        ),

      ),
    );

  }

}