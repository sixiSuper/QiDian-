import 'package:flutter/material.dart';

alertDialog(BuildContext context, {String title = '标题', String content = '内容'}) async {
  var res = await showDialog(
      context: context,
      barrierDismissible: false, // 点击背景是否关闭弹窗
      builder: (context) {
        return AlertDialog(
          title: Text(title), // 标题
          content: Text(content), // 内容区域
          // 按钮组，自定义增加按钮数量
          actions: [
            // 取消按钮
            TextButton(
                onPressed: () {
                  print('cancel');
                  // 关闭弹窗，pop() 中传入的参数将会作为返回值，需配合异步使用
                  Navigator.pop(context, false);
                },
                child: const Text('取消')),

            // 确定按钮
            TextButton(
                onPressed: () {
                  print('ok');
                  // 关闭弹窗，pop() 中传入的参数将会作为返回值，需配合异步使用
                  Navigator.pop(context, true);
                },
                child: const Text('确认')),
          ],
        );
      });
  // 返回结果
  return res;
}
