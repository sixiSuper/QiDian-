import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

alertDialog(
  BuildContext context, {
  String title = '标题',
  String content = '内容',

  /// 弹窗是否可取消
  bool cancellable = true,

  /// 自定义内容组件
  Widget? child,
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),

            // 内容
            title: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)), // 标题
            content: child ?? Text(content), // 内容区域

            // 按钮组，自定义增加按钮数量
            actions: [
              // 取消按钮
              Visibility(
                visible: cancellable, // 组件显示/隐藏
                child: TextButton(
                    onPressed: () {
                      print('cancel');
                      // 关闭弹窗，pop() 中传入的参数将会作为返回值，需配合异步使用
                      Navigator.pop(context, false);
                    },
                    child: const Text('取消')),
              ),

              // 确定按钮
              TextButton(
                  onPressed: () {
                    print('ok');
                    // 关闭弹窗，pop() 中传入的参数将会作为返回值，需配合异步使用
                    Navigator.pop(context, true);
                  },
                  child: const Text('确认')),
            ],
          ),
          Positioned(top: 0, left: 0, child: DragToMoveArea(child: SizedBox(width: size.width, height: 50)))
        ]);
      });
  // 返回结果
  return res;
}
