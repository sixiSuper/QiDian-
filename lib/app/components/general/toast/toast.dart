import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // 引入轻提示组件库

_toast(context, String text) {
  // 固定写法，从第三方组件库文档里面复制的
  Fluttertoast.showToast(
      msg: text,
      // 针对 Android 平台的提示时间 LENGTH_SHORT 代表短时间，LENGTH_LONG 代表长时间
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER, // 显示的位置
      timeInSecForIosWeb: 5, // 提示时间，仅在 ios 和 web 端生效
      backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4), // 背景颜色
      textColor: Colors.white, // 文字颜色
      fontSize: 16.0);
}
