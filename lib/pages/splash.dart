import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shellbook_flutter/network.dart';
import '../model/Order.dart';
import '../model/Book.dart';
import '../model/OrderToBook.dart';
import '../database/CustomDatabase.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/books.json');
}

class SplashPage extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}


class SplashState extends State<SplashPage> {

  CustomDatabase database;
  Timer _t;
  @override
  initState() {
    super.initState();
    database = new CustomDatabase();

    Timer _t = new Timer(const Duration(milliseconds: 1500), () {
      try {
        checkLoginStatus().then((login){
          print(login);
          if(!login){
            database.initDB()
                .then((database){
              print("database init compeleted");
            });
            loadAsset().then((data)async {
              List books = JSON.decode(data);
              print(books.length);
              for(int i = 0 ; i < books.length; i++){
                Book book = Book.fromJson(books[i]);
                await database.addBook(book);
              }
            }).whenComplete((){
              print("import book compeleted");
//              Navigator.pushReplacementNamed(context, "/login");
            });
          }else{
            Navigator.pushReplacementNamed(context, "/homePage");
          }
        });
      } catch (e) {
        print(e);
      }
    });

  }



  syncDatabase()async{
//    NetWork.instance.get("http://www.mocky.io/v2/5b7bf5bf2e00005400bfe226")
//        .then((res){
//          List jsonA = JSON.decode(res.data.toString());
//          print(jsonA.toString());
//          for(int i = 0 ; i < jsonA.length;i++){
//            Order order =Order.fromJson(jsonA[i]['order']);
//            database.addOrder(order);
//            List books = jsonA[i]['books'];
//            for(int j = 0; j < books.length; j ++){
//              Book book = Book.fromJson(books[j]);
//              database.addBook(book);
//            }
//          }
//          database.selectFromOrder().then((list){
//            print("select");
//            for(int i = 0 ; i< list.length; i ++){
//              print(list[i]['id']);
//              print(list[i]['nickname']);
//            }
//          });
//    });
      database.selectFromBook().then((list){
        print(list.length);
      });
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool login = prefs.getBool('Login');
    return login == true;
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Center(
        child: new Stack(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image:new ExactAssetImage('images/login_bg.png'),
                        fit:BoxFit.cover
                    )
                ),
              ),
              Center(
                child:  MaterialButton(
                  child: Text('test sync'),
                  textColor: Colors.white,
                  onPressed: syncDatabase,)
              )
            ]
        ),
      ),
    );
  }
}