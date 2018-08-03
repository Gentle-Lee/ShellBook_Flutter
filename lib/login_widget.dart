import 'package:flutter/material.dart';
class Login extends StatelessWidget {
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
              new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0,bottom: 120.0),
                    child:new InputField(),
                  ),
                ],
              )
            ]
        ),
      ),
    );
  }
}

class InputField extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new InputFieldState();
  }
}

class InputFieldState extends State<InputField>{
  //用户名输入框的控制器
  TextEditingController _userNameController = new TextEditingController();
  //密码输入框的控制器
  TextEditingController _userPasswordController = new TextEditingController();
  void onTextClear() {
    setState(() {
      _userNameController.text = "";
      _userPasswordController.text = "";
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
          child: new TextField(
            controller: _userNameController,
            decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                icon: new Icon(Icons.perm_identity),
                hintText: "请输入账号"),
          ),
        ),
        new Container(
          decoration: new BoxDecoration(color: Colors.white),
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
          child: new TextField(
            controller: _userPasswordController,
            decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                icon: new Icon(Icons.lock),
                hintText: "请输入密码",

            ),
            obscureText: true,
          ),
        ),
        new Builder(builder: (BuildContext context) {
          //监听RaisedButton的点击事件，并做相应的处理
          return new RaisedButton(
              onPressed: () {
                if (_userNameController.text.toString() == 'test' &&
                    _userPasswordController.text.toString() == 'admin') {
                  Scaffold.of(context).showSnackBar(
                      new SnackBar(content: new Text("登录成功")));
                } else {
                  Scaffold.of(context).showSnackBar(
                      new SnackBar(content: new Text("登录失败，用户名密码有误")));
                }
                onTextClear();
              },
              color: Colors.blue,
              highlightColor: Colors.lightBlueAccent,
              disabledColor: Colors.lightBlueAccent,
              child: new Text(
                "登录",
                style: new TextStyle(color: Colors.white),
              ));
        })
      ],
    );
  }
}
