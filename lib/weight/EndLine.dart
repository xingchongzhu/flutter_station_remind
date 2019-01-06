/*
 * Copyright (c) 2019. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:flutter/material.dart';
import 'package:flutter_app_battery/res/YcColors.dart';


/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/9/11
 *     desc  : 加载view
 *     revise:
 * </pre>
 */
class EndLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: const Color(0xFFEEEEEE),
      padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Divider(height: 10.0,),
            flex: 1,
          ),
          new Text("没有更多数据呢！",style: new TextStyle(color: YcColors.colorPrimary),),
          new Expanded(
            child: new Divider(height: 10.0,),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: const Color(0xFFEEEEEE),
      padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Divider(height: 10.0,),
            flex: 1,
          ),
          new Text("暂时没有数据",style: new TextStyle(color: YcColors.colorPrimary),),
          new Expanded(
            child: new Divider(height: 10.0,),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
