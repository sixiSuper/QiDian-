// ...
// 容器组件
// ...

import 'package:flutter/material.dart';

Widget container(
  context, {
  Widget? child, // 容器
  double width = double.infinity, // 宽度
  double? height, // 高度
  EdgeInsets margin = const EdgeInsets.all(15), // 外边距
  EdgeInsets padding = const EdgeInsets.all(10), // 内边距
  double radius = 10, // 圆角
  bool shadow = true, // 阴影
  bool bottomBorder = false, // 下边框
}) {
  return Container(
    width: width, // 宽度
    height: height,
    margin: margin,
    padding: padding,

    // 容器样式
    decoration: BoxDecoration(
      // color: Theme.of(context).colorScheme.background.withOpacity(0.6), // 颜色
      color: Colors.white, // 颜色
      borderRadius: BorderRadius.circular(radius), // 圆角
      // 阴影样式
      boxShadow: [
        BoxShadow(
          color: (Theme.of(context).cardTheme.shadowColor)!,
          blurRadius: shadow ? 5 : 0,
        ),
      ],

      // 边框样式
      border: Border(
        // 下边框
        bottom: bottomBorder ? BorderSide(width: 1, color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.2)) : const BorderSide(color: Colors.transparent),
      ),
    ),
    child: child,
  );
}
