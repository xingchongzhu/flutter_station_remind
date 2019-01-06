/*
 * Copyright (c) 2019. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:flutter/material.dart';
import 'package:flutter_app_battery/pages/find/FindPage.dart';
import 'package:flutter_app_battery/pages/home/HomePage.dart';
import 'package:flutter_app_battery/pages/me/MePage.dart';
import 'package:flutter_app_battery/pages/search/SearchPage.dart';
import 'package:flutter_app_battery/pages/todo/TodoPage.dart';
import 'package:flutter_app_battery/res/YcColors.dart';


class MainDart extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    MainDartState mainDartState = new MainDartState();
    return mainDartState;
  }
}

class MainDartState extends State<MainDart> with TickerProviderStateMixin {

  //默认索引
  int positionIndex = 0;
  //底部导航栏
  var mainTitles = ['首页', '发现','其他', '我的'];
  var indexStack;
  List<BottomNavigationBarItem> navigationViews;
  final navigatorKey = GlobalKey<NavigatorState>();

  //重写该方法，初始化作用
  @override
  Widget build(BuildContext context) {
    initData();
    return new MaterialApp(
      navigatorKey: navigatorKey,
      //设置主题
      theme: ThemeData(
          accentColor: Colors.black,
          textSelectionColor: YcColors.colorWhite,
          primaryColor: YcColors.colorPrimary),

      //设置home
      home: new Scaffold(
        //设置appBar
        appBar: new AppBar(
          //title
          title: new Text(
            mainTitles[positionIndex],
            style: new TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),
          ),

          //这个相当于actionBar上的menu
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.account_balance),
                onPressed: () {
                  navigatorKey.currentState.push(new MaterialPageRoute(builder: (context) {
                    return null;
                  }));
                }),
            new IconButton(
                icon: new Icon(Icons.add_a_photo),
                onPressed: () {
                  navigatorKey.currentState.push(new MaterialPageRoute(builder: (context) {
                    return null;
                  }));
                }),
            new IconButton(
                icon: new Icon(Icons.search),
                onPressed: () {
                  navigatorKey.currentState.push(new MaterialPageRoute(builder: (context) {
                    return new SearchPage(null);
                  }));
                }),
          ],
        ),
        body: indexStack,

        //相当于底部导航栏
        bottomNavigationBar: new BottomNavigationBar(
          items: navigationViews.map((BottomNavigationBarItem navigationView) => navigationView).toList(),
          currentIndex: positionIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              positionIndex = index;
            });
          },
        ),
      ),
    );
  }

  //这个方法
  @override
  void initState() {
    super.initState();
    navigationViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: new Text(mainTitles[0]),
        backgroundColor: Colors.black,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.assignment),
        title: new Text(mainTitles[1]),
        backgroundColor: Colors.black,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.devices_other),
        title: new Text(mainTitles[2]),
        backgroundColor: Colors.black,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        title: new Text(mainTitles[3]),
        backgroundColor: Colors.black,
      ),
    ];
  }


  //初始化数据
  void initData() {
    indexStack = new IndexedStack(
      children: <Widget>[new HomePage(), new FindPage(),new TodoPage(), new MePage()],
      index: positionIndex,
    );
  }

}
