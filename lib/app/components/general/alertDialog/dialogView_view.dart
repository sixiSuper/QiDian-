import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../button/button.dart';

dialogView(
  BuildContext context, {
  Widget? child,
  Function? onPressed,
  String? btnText,
  IconData btnIcon = Icons.add,
}) async {
  var res = await showDialog(
      context: context,
      barrierDismissible: false, // 点击背景是否关闭弹窗
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Stack(alignment: Alignment.center, children: [
          AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            surfaceTintColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(15),
            actionsPadding: const EdgeInsets.all(15),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),

            // 内容
            content: child, // 内容区域

            actions: [
              // 确定按钮
              primaryIconButton(
                context,
                label: Text(btnText ?? '确认'),
                icon: btnIcon,

                // 处理函数
                onPressed: () {
                  print('ok');
                  // 关闭弹窗，pop() 中传入的参数将会作为返回值，需配合异步使用
                  Navigator.pop(context, true);
                  onPressed?.call();
                },
              ),
            ],
          ),
          Positioned(top: 0, left: 0, child: DragToMoveArea(child: SizedBox(width: size.width, height: 50)))
        ]);
      });
  // 返回结果
  return res;
}
