import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterWebviewPlugin {
  static const MethodChannel _channel = const MethodChannel('flutter_webview_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('loadWeb');
    return version;
  }

  //声明plugin加载的方法在这里就是launch
//url参数要加载的地址，callback回调，
//可选参数Rect（控制）plugin的大小
  Future<Null> launch(
      String url,
      Function callback, {
        Rect rect,
      }) async {
    Map<String, dynamic> args = {
      "url": url,
    };
    if (rect != null) {
      args["rect"] = {
        "left": rect.left,
        "top": rect.top,
        "width": rect.width,
        "height": rect.height
      };
    }
    final String result = await _channel.invokeMethod('load', args);

    if (callback != null) {
      callback(result);
    }
  }
}

