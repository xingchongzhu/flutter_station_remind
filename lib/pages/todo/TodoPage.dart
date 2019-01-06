
/*
 * Copyright (c) 2019. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:flutter/material.dart';
import 'package:flutter_app_battery/pages/todo/serviceCard.dart';
import 'package:flutter_app_battery/res/YcColors.dart';
import 'package:flutter_app_battery/weight/wallpager/BannerPageView.dart';


/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/12/09
 *     desc  : todo页面
 *     revise:
 * </pre>
 */
class TodoPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new TodoState();
  }
}

class TodoState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    var bannerPageView = new BannerPageView();
    var container = new Container(height: 180.0, child: bannerPageView,);
    return new Scaffold(
        body: new SingleChildScrollView(
          child: new Container(
            color: YcColors.colorWhite,
            child: new Column(
              children: <Widget>[
                container,
                serviceView(context),
              ],
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

}