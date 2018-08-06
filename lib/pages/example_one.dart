import 'package:flutter/material.dart';

class ExampleOne extends StatefulWidget {
  final String title;
  ExampleOne({Key key, this.title}) : super(key: key);

  @override
  _ExampleOneState createState() => new _ExampleOneState();
}

class _ExampleOneState extends State<ExampleOne> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.account_circle ),
                  title: new Text('username'),
                  subtitle: new Text('orderTime'),
                  trailing: new Text('unPackaged'),
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.book ),
                      title: Column(
                        children: <Widget>[
                          Text('bookName'),
                          Text('bookedition'),
                          Text('bookAuthor')
                        ],
                      ),
                    );
                  },
                  itemCount: 4,
                  shrinkWrap: true, // todo comment this out and check the result
                  physics: ClampingScrollPhysics(), // todo comment this out and check the result
                ),
                Row(
                  children: <Widget>[
                    FlatButton(
                      child: new Text('contact'),
                      onPressed: () {},
                    ),
                    MaterialButton(
                      child: new Text('finish'),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: 9,
      ),
    );
  }
}
