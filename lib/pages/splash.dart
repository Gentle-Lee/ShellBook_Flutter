import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashPage extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}


class SplashState extends State<SplashPage> {

  Timer _t;
  @override
  initState() {
    super.initState();
    Timer _t = new Timer(const Duration(milliseconds: 1500), () {
      try {
        checkLoginStatus();
      } catch (e) {

      }
    });

  }
  checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool login = prefs.getBool('Login');
    if(login){
      Navigator.pushReplacementNamed(context, "/homePage");
    }else{
      Navigator.pushReplacementNamed(context, "/login");
    }
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
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            ]
        ),
      ),
    );
  }
}