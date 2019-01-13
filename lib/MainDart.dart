/*
 * Copyright (c) 2019. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:flutter/material.dart';
import 'package:remind/common/Constants.dart';
import 'package:remind/pages/home/FullMapPage.dart';
import 'package:remind/pages/home/LineMapPage.dart';
import 'package:remind/pages/home/RemindPage.dart';
import 'package:remind/pages/search/SearchPage.dart';
import 'package:remind/res/YcColors.dart';
import 'package:remind/res/YcString.dart';

class MainDart extends StatefulWidget {
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
  var mainTitles = ['全图', '路线', '提醒'];
  var indexStack;
  List<BottomNavigationBarItem> navigationViews;
  final navigatorKey = GlobalKey<NavigatorState>();

  //重写该方法，初始化作用
  @override
  Widget build(BuildContext context) {
    initData();
    return new MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      //设置主题
      theme: ThemeData(
          accentColor: Colors.black,
          textSelectionColor: YcColors.colorWhite,
          primaryColor: YcColors.colorPrimary),

      //设置home
      home: new Scaffold(
        //设置appBar
        appBar: PreferredSize(
            child: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,
              actions: <Widget>[
                new Center(
                  child: new Text(
                    YcString.current_city,
                    style: new TextStyle(fontSize: 16.0, color: Colors.blue),
                  ),
                ),
                new Icon(Icons.search, color: Colors.blue),
              ],
              leading: new Icon(Icons.search, color: Colors.blue),
              title: new Text(
                YcString.search_text_title,
                style: new TextStyle(fontSize: 10.0, color: Colors.blue),
              ),
            ),
            preferredSize: Size.fromHeight(40)),

        body: indexStack,

        //相当于底部导航栏
        bottomNavigationBar: new BottomNavigationBar(
          items: navigationViews
              .map((BottomNavigationBarItem navigationView) => navigationView)
              .toList(),
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

  void _tapSearchPage() {
    navigatorKey.currentState.push(new MaterialPageRoute(builder: (context) {
      return new SearchPage();
    }));
  }

  //这个方法
  @override
  void initState() {
    super.initState();
    navigationViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: const Icon(Icons.blur_circular),
        activeIcon: const Icon(Icons.blur_circular, color: Colors.blue),
        title: new Text(mainTitles[0]),
        backgroundColor: Colors.blue,
      ),
      new BottomNavigationBarItem(
        icon: initImage('lib/image/home_full.png',Colors.grey),
        activeIcon: initImage('lib/image/home_full.png',Colors.blue),
        title: new Text(mainTitles[1]),
        backgroundColor: Colors.blue,
      ),
      new BottomNavigationBarItem(
        icon: initImage('lib/image/home_full.png',Colors.grey),
        activeIcon: initImage('lib/image/home_full.png',Colors.blue),
        title: new Text(mainTitles[2]),
        backgroundColor: Colors.blue,
      ),
    ];
  }

  Widget initImage(String iconPath,Color color) {
    Widget icon = new Image.asset(
      iconPath,
      width: Constants.NAVIGATIONICONSIZE,
      height: Constants.NAVIGATIONICONSIZE,
      color: color,
    );
    return icon;
  }

  //初始化数据
  void initData() {
    indexStack = new IndexedStack(
      children: <Widget>[
        new FullMapPadge(),
        new LineMapPadge(),
        new RemindPadge()
      ],
      index: positionIndex,
    );
  }
}
