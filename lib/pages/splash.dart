import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shellbook_flutter/network.dart';
import '../model/Order.dart';
import '../model/Book.dart';
import '../model/OrderToBook.dart';
import '../database/CustomDatabase.dart';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';


class SplashPage extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}


class SplashState extends State<SplashPage> {

  CustomDatabase database;
  bool mLogin = false;
  Timer _t;
  @override
  initState() {
    super.initState();
    database = new CustomDatabase();
    checkLoginStatus().then((login){
      setState(() {
        mLogin = login;
      });
      return login;
    }).then((login){
      print(login);
      checkInternetStatus().then((connected){
        if(connected){
          syncDatabase().then((data){
            return 1;
          });
        }else{
          return 2;
        }
      }).then((data){
        print(data);
        if(mLogin){
          Navigator.pushReplacementNamed(context, "/homePage");
        }else{
          Navigator.pushReplacementNamed(context, "/login");
        }
      });
    });
  }


  Future<bool> checkInternetStatus()async{
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<bool> syncDatabase()async{
    await NetWork.instance.get(NetWork.ALL_ORDER)
        .then((res)async {
          List jsonA = const JsonCodec().decode(res.data.toString());
          for(int i = 0 ; i < jsonA.length;i++){
            Order order =Order.fromJson(jsonA[i]['order']);
            await database.addOrder(order);
            List books = jsonA[i]['map'];
            for(int j = 0; j < books.length; j ++){
              OrderToBook orderToBook = OrderToBook.fromJson(books[j]);
              await database.addOrderToBook(orderToBook);
            }
          }
          return true;
    });
    return false;
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool login = prefs.getBool('Login');
    return login == true;
  }

  @override
  void dispose() {
    super.dispose();
//    _t.cancel();
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
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                )
              )
            ]
        ),
      ),
    );
  }
}