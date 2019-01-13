import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remind/webview/WebviewPlugin.dart';

class FullMapPadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Webview',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();

  @override
  initState() {}
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription<String> _back;
  var title = "demo";

  final flutterWebviewPlugin = new WebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new Center(
      child: new RaisedButton(onPressed: () {
        flutterWebviewPlugin.launch(
            "https://blog.csdn.net/qq_16247851/article/details/81210771",
                (data) {
              setState(() {
                title = data;
              });
            },
            rect: new Rect.fromLTWH(0.0, 0.0, MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height));
      }),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
