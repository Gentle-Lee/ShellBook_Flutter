import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WebPageState();
  }

}

class WebPageState extends State<WebPage>{
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      appBar: new AppBar(
        title: new Text('自取码'),
      ),
      url: "https://www.baidu.com/",
      withJavascript: true,
      withLocalStorage: true,
      withZoom: false,
    );
  }

}