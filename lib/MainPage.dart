import 'package:flutter/material.dart';
import 'package:remind/common/Constants.dart';
import 'package:remind/pages/home/FullMapPage.dart';
import 'package:remind/pages/home/LineMapPage.dart';
import 'package:remind/pages/home/RemindPage.dart';
import 'package:remind/pages/search/SearchPage.dart';
import 'package:remind/res/YcColors.dart';
import 'package:remind/res/YcString.dart';
import 'package:remind/view/ImageTapWidget.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, home: new MainPageWidget());
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPageWidget> {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['全图', '路线', '提醒'];

  /*
   * 存放三个页面，跟fragmentList一样
   */
  var _pageList;

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff1296db)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff515151)));
    }
  }

  Image getTabImage(String path, Color color, double size) {
    Widget icon = new Image.asset(
      path,
      width: size,
      height: size,
      color: color,
    );
    return icon;
  }

  void initData() {
    /*
     * 初始化选中和未选中的icon
     */
    tabImages = [
      [
        getTabImage('lib/image/home_full.png', Colors.grey,
            Constants.NAVIGATIONICONSIZE),
        getTabImage('lib/image/home_full.png', Colors.blue,
            Constants.NAVIGATIONICONSIZE)
      ],
      [
        getTabImage('lib/image/home_line.png', Colors.grey,
            Constants.NAVIGATIONICONSIZE),
        getTabImage('lib/image/home_line.png', Colors.blue,
            Constants.NAVIGATIONICONSIZE)
      ],
      [
        getTabImage('lib/image/home_remind.png', Colors.grey,
            Constants.NAVIGATIONICONSIZE),
        getTabImage('lib/image/home_remind.png', Colors.blue,
            Constants.NAVIGATIONICONSIZE)
      ]
    ];
    /*
     * 三个子界面
     */
    _pageList = [
      new FullMapPadge(),
      new LineMapPadge(),
      new RemindPadge(),
    ];
  }

  Function _tap() {}

  @override
  Widget build(BuildContext context) {
    //初始化数据
    initData();
    return Scaffold(
        //设置appBar
        appBar: PreferredSize(
            child: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,
              actions: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(5),
                  child: new ImageTapWidget(
                      child: new Center(
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              YcString.current_city,
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.blue),
                            ),
                            getTabImage('lib/ic_select_city_down.png',
                                Colors.blue, Constants.NAVIGATIONICONSIZE),
                          ],
                        ),
                      ),
                      onTap: _tap),
                ),
              ],
              flexibleSpace: new Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: new ImageTapWidget(
                  child: new Center(
                    child: new Row(children: <Widget>[
                      Icon(Icons.search, color: Colors.blue),
                      new Text(
                        YcString.search_text_title,
                        style:
                            new TextStyle(fontSize: 10.0, color: Colors.blue),
                      ),
                    ]),
                  ),
                ),
              ),
              /* title: new Text(
                YcString.search_text_title,
                style: new TextStyle(fontSize: 10.0, color: Colors.blue),
              ),*/
            ),
            preferredSize: Size.fromHeight(40)),
        body: _pageList[_tabIndex],
        bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTabIcon(0), title: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: getTabIcon(1), title: getTabTitle(1)),
            new BottomNavigationBarItem(
                icon: getTabIcon(2), title: getTabTitle(2)),
          ],
          type: BottomNavigationBarType.fixed,
          //默认选中首页
          currentIndex: _tabIndex,
          iconSize: 24.0,
          //点击事件
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ));
  }
}
