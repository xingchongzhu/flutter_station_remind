
/*
 * Copyright (c) 2019. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:flutter/material.dart';
import 'package:flutter_app_battery/api/AndroidApi.dart';
import 'package:flutter_app_battery/api/HttpUtils.dart';
import 'package:flutter_app_battery/pages/find/HierarchyPage.dart';
import 'package:flutter_app_battery/res/YcColors.dart';


/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/8/22
 *     desc  : 知识体系页面
 *     revise:
 * </pre>
 */
class FindPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new FindState();
  }
}

class FindState extends State<FindPage> {

  var listData;

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, i) => createItem(i),
      );
      return listView;
    }
  }

  @override
  void initState() {
    super.initState();
    //从网络获取数据
    getTree();
  }

  Widget createItem(int i) {
    var itemData = listData[i];
    List list = itemData['children'];
    var length = list.length;
    String total = length.toString()+'分类';
    //创建标题控件
    Text title = createTextTitle(itemData);
    //折叠控件展开后展示该控件。默认不展开，点击箭头后展开，如何操作
    //Text content = createTextContent(list);
    return new Card(
      elevation: 1.0,
      child: new InkWell(
        onTap: () {
          onItemClick(itemData,i);
        },
        child: new Container(
          padding: EdgeInsets.all(15.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: title,
                    ),
                  ],
                ),
              ),
              new Text(
                total,
                softWrap: true,
                style: new TextStyle(fontSize: 14.0, color: YcColors.colorRed50, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              new Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
            ],
          ),
        ),
      ),
    );
  }

  //点击事件，跳转到知识体系的tab页面
  //更多可以看我的GitHub博客汇总：https://github.com/yangchong211/YCBlogs
  void onItemClick(itemData, int i) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new HierarchyPage(itemData);
    }));
  }

  //创建标题控件
  Text createTextTitle(itemData) {
    Text title = new Text(
      itemData['name'],
      softWrap: true,
      style: new TextStyle(fontSize: 16.0, color: YcColors.colorPrimary, fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );
    return title;
  }

  //折叠控件展开后展示该控件
  Text createTextContent(List list) {
    String strContent = '';
    for (var value in list) {
      strContent +='${value["name"]}   ';
    }
    Text content = new Text(
      strContent,
      softWrap: true,
      style: new TextStyle(color: YcColors.colorBlack87 , fontSize: 12.0,),
      textAlign: TextAlign.left,
    );
    return content;
  }

  //从网络获取数据，注意需要添加async
  void getTree() async {
    HttpUtils.get(AndroidApi.TREE, (data) {
      setState(() {
        listData = data;
      });
    });
  }

}