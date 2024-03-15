// ...
// 自定义输入框
// ...

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget textInput(
  BuildContext context, {
  bool error = false,
  String errorText = 'error',
  Function? onChanged,
}) {
  Color errorColor = Theme.of(context).colorScheme.error;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 输入框本体
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          // 边框根据错误状态决定是否显示
          border: Border.all(width: 1, color: error ? errorColor : Colors.transparent),
          borderRadius: BorderRadius.circular(5),
          // 背景颜色根据错误状态决定显示的颜色
          color: error ? errorColor.withOpacity(0.1) : Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
        ),
        child: _textField(context, error, onChanged: (text) {
          onChanged!(text);
        }),
      ),

      // 错误提示文字
      Visibility(
          visible: error,
          child: Container(
            height: 13,
            margin: const EdgeInsets.only(top: 1, left: 1.5),
            child: Text(errorText,
                style: TextStyle(
                  fontSize: 12,
                  color: errorColor,
                )),
          ))
    ],
  );
}

// 输入框模板
Widget _textField(BuildContext context, error, {Function? onChanged}) {
  // 错误颜色
  Color errorColor = Theme.of(context).colorScheme.error;
  return TextField(
    scrollPadding: EdgeInsets.zero,
    style: TextStyle(
      fontSize: 14,
      color: error ? errorColor : Theme.of(context).colorScheme.onPrimary,
      fontWeight: error ? FontWeight.w500 : FontWeight.normal,
    ),
    decoration: InputDecoration(
      hintText: '请输入..',
      hintStyle: TextStyle(
        fontSize: 14,
        color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.6),
      ),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.all(2),
      isDense: true,
      alignLabelWithHint: true,
    ),

    // 监听输入内容
    onChanged: (text) {
      print(text);
      onChanged!(text);
    },
  );
}
