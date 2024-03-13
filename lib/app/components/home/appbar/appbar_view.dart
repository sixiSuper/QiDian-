// ...
// 顶部导航栏（包含窗口操作按钮）
// ...

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

AppBar appbar(BuildContext context, controller) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
    title: DragToMoveArea(
      child: Container(
        width: double.infinity,
        height: 100,
        // color: Colors.amber,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 标题
            const Text(
              'QiDian',
              style: TextStyle(
                fontSize: 18,
                fontFamily: '微软雅黑',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(31, 41, 55, 1),
              ),
            ),
            // 右侧操作按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 最小化窗口
                IconButton(
                  // 隐藏反馈效果
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,

                  // 点击事件
                  onPressed: () {
                    windowManager.minimize();
                  },
                  icon: Icon(
                    Icons.horizontal_rule_rounded,
                    color: Theme.of(context).colorScheme.onSecondary,
                    size: 20,
                  ),
                ),

                // 最大化/恢复窗口
                const Padding(padding: EdgeInsets.all(10)),
                IconButton(
                  // 隐藏反馈效果
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,

                  // 点击事件
                  onPressed: () {
                    // 判断窗口状态，并执行对应操作
                    if (controller.isMaximized.value) {
                      windowManager.restore();
                    } else {
                      windowManager.maximize();
                    }
                  },
                  icon: Obx(() => Icon(
                        controller.isMaximized.value ? Icons.filter_none : Icons.crop_din,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: controller.isMaximized.value ? 14 : 16,
                      )),
                ),

                // 关闭窗口按钮
                const Padding(padding: EdgeInsets.all(10)),
                IconButton(
                  // 隐藏反馈效果
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,

                  // 点击事件
                  onPressed: () {
                    windowManager.close();
                  },
                  icon: Icon(
                    Icons.clear_rounded,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 24,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    centerTitle: true,
  );
}
