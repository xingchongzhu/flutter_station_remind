/*
 * Copyright (c) 2019. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_battery/api/AndroidApi.dart';
import 'package:flutter_app_battery/api/HttpUtils.dart';
import 'package:flutter_app_battery/common/Constants.dart';
import 'package:flutter_app_battery/pages/home/ArticleItem.dart';
import 'package:flutter_app_battery/weight/EndLine.dart';

/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/11/18
 *     desc  : 搜索页面
 *     revise:
 * </pre>
 */
class SearchListPage extends StatefulWidget {
  
  String id;
  SearchListPageState searchListPageState;
  SearchListPage(ValueKey<String> key) : super(key: key) {
    this.id = key.value.toString();
  }
  
  @override
  State<StatefulWidget> createState() {
    return new SearchListPageState();
  }
}

class SearchListPageState extends State<SearchListPage> {
  
  int curPage = 0;
  Map<String, String> map = new Map();
  List listData = new List();
  int listTotalSize = 0;
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    articleQuery();
    addListener();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (listData == null || listData.isEmpty) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, i) => buildItem(i),
        controller: scrollController,
      );
      return new RefreshIndicator(child: listView, onRefresh: pullToRefresh);
    }
  }

  Widget buildItem(int i) {
    var itemData = listData[i];
    if (i == listData.length - 1 &&
        itemData.toString() == Constants.complete) {
      return new EndLine();
    }
    return new ArticleItem.isFromSearch(itemData, widget.id);
  }

  //添加监听事件
  void addListener() {
    scrollController.addListener(() {
      var maxScroll = scrollController.position.maxScrollExtent;
      var pixels = scrollController.position.pixels;
      if (maxScroll == pixels && listData.length < listTotalSize) {
        articleQuery();
      }
    });
  }

  //刷新数据
  Future<Null> pullToRefresh() async {
    curPage = 0;
    articleQuery();
    return null;
  }

  //请求接口搜索
  void articleQuery() {
    String url = AndroidApi.ARTICLE_QUERY;
    url += "$curPage/json";
    map['k'] = widget.id;
    HttpUtils.post(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = data;
        var datas = map['datas'];
        listTotalSize = map["total"];
        setState(() {
          List list1 = new List();
          if (curPage == 0) {
            listData.clear();
          }
          curPage++;
          list1.addAll(listData);
          list1.addAll(datas);
          if (list1.length >= listTotalSize) {
            list1.add(Constants.complete);
          }
          listData = list1;
        });
      }
    }, params: map);
  }


}
