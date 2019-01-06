

/*
 * Copyright (c) 2019. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:flutter/material.dart';
import 'package:flutter_app_battery/res/YcColors.dart';

class ItemLine extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var divider = new Divider(height: 1.0,indent: 1.0, color: YcColors.colorLine);
    return divider;
  }
}

