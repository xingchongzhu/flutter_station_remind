/*
 * Copyright (c) 2019. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:flutter/widgets.dart';
import 'package:remind/res/YcColors.dart';


/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/11/15
 *     desc  : String工具类
 *     revise:
 * </pre>
 */
class StringUtils {
  // 保存用户登录信息，data中包含了token等信息
  static TextSpan getTextSpan(String text, String key) {
    if (text == null || key == null) {
      return null;
    }
    String splitString1 = "<em class='highlight'>";
    String splitString2 = "</em>";
    String textOrigin = text.replaceAll(splitString1, '').replaceAll(splitString2, '');
    TextSpan textSpan = new TextSpan(text: key, style: new TextStyle(color: YcColors.colorPrimary));
    List<String> split = textOrigin.split(key);
    List<TextSpan> list = new List<TextSpan>();
    for (int i = 0; i < split.length; i++) {
      list.add(new TextSpan(text: split[i]));
      list.add(textSpan);
    }
    list.removeAt(list.length - 1);
    return new TextSpan(children: list);
  }
}
