import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shellbook_flutter/network.dart';
import '../model/Order.dart';
import '../model/Book.dart';
import '../model/OrderToBook.dart';
import '../database/CustomDatabase.dart';
import 'dart:convert';


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

    _t = new Timer(const Duration(milliseconds: 5000), () {
      checkLoginStatus().then((login)async {
        if(login){
          Navigator.pushReplacementNamed(context, "/homePage");
        }else{
          Navigator.pushReplacementNamed(context, "/login");
        }
      });
    });
    syncDatabase();
  }



  Future syncDatabase()async{
    NetWork.instance.get("http://www.mocky.io/v2/5b7cd57d3300002a004a001d")
        .then((res)async {
          List jsonA = JSON.decode(res.data.toString());
          print(jsonA.toString());
          for(int i = 0 ; i < jsonA.length;i++){
            Order order =Order.fromJson(jsonA[i]['order']);
            await database.addOrder(order);
            List books = jsonA[i]['map'];
            for(int j = 0; j < books.length; j ++){
              OrderToBook orderToBook = OrderToBook.fromJson(books[j]);
              await database.addOrderToBook(orderToBook);
            }
          }
    });
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool login = prefs.getBool('Login');
    return login == true;
  }

  @override
  void dispose() {
    super.dispose();
    _t.cancel();
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
                child:  new CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              )
            ]
        ),
      ),
    );
  }
}