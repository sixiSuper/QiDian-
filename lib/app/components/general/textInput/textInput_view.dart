// ...
// 自定义输入框
// ...

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget textInput(
  BuildContext context, {
  bool error = false,
  String text = 'niubi',
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
        child: _textField(
          context,
          error,
          text: text,
          onChanged: (t) {
            onChanged!(t);
          },
        ),
      ),

      // 错误提示文字
      Visibility(
          visible: error,
          child: Container(
            height: 14,
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
Widget _textField(BuildContext context, error, {Function? onChanged, String text = ''}) {
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
    onChanged: (t) {
      print(t);
      // text = t;
      // 回调
      onChanged!(t);
    },

    // 输入框控制器（实现双向数据绑定）
    controller: TextEditingController.fromValue(TextEditingValue(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(
          affinity: TextAffinity.downstream,
          offset: text.length,
        ),
      ),
    )),
  );
}
