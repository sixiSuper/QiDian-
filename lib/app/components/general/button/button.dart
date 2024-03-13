// ...
// 容器组件
// ...

import 'package:flutter/material.dart';

// 主要图标按钮
Widget primaryIconButton(
  BuildContext context, {
  Widget label = const Text('按钮内容'),
  IconData icon = Icons.add, // 按钮图标
  String iconPosition = 'left', // 图标位置 left | right
  Function()? onPressed, // 按钮点击事件
}) {
  return Container(
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.primary),
        foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white.withOpacity(0.95)),
        overlayColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.05)),
        shadowColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        surfaceTintColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        // 形状
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          // 圆角矩形
          borderRadius: BorderRadius.circular(5),
        )),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 15)),
      ),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconPosition == 'left' ? Icon(icon) : label,
          const Padding(padding: EdgeInsets.all(4)),
          iconPosition == 'right' ? Icon(icon) : label,
        ],
      ),
    ),
  );
}

// 次要图标按钮
Widget secondaryIconButton(
  BuildContext context, {
  Widget label = const Text('按钮内容'),
  IconData icon = Icons.add, // 按钮图标
  String iconPosition = 'left', // 图标位置 left | right
  Function()? onPressed, // 按钮点击事件
}) {
  return Container(
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      // border: Border.all(color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.3), width: 1),
    ),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.onSecondary.withOpacity(0.15)),
        foregroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.onPrimary),
        overlayColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.05)),
        shadowColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        surfaceTintColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        // 形状
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          // 圆角矩形
          borderRadius: BorderRadius.circular(5),
        )),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 15)),
      ),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconPosition == 'left' ? Icon(icon) : label,
          const Padding(padding: EdgeInsets.all(4)),
          iconPosition == 'right' ? Icon(icon) : label,
        ],
      ),
    ),
  );
}

// 线形按钮
Widget borderButton(
  BuildContext context, {
  Widget label = const Text('按钮内容'),
  // IconData icon = Icons.add, // 按钮图标
  Function()? onPressed, // 按钮点击事件
}) {
  return Container(
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.3), width: 1),
    ),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        foregroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)),
        overlayColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.05)),
        shadowColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        surfaceTintColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        // 形状
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          // 圆角矩形
          borderRadius: BorderRadius.circular(5),
        )),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 18)),
      ),
      onPressed: onPressed,
      child: label,
    ),
  );
}
