// ...
// 页眉组件
// ...

import 'package:bulk_renaming_flutter/app/components/general/container/container.dart';
import 'package:flutter/material.dart';

import '../../general/button/button.dart';

Widget pageTitle(BuildContext context, controller) {
  return container(
    context,

    // 样式
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
    margin: const EdgeInsets.all(0),
    radius: 0,
    shadow: false,
    bottomBorder: true,

    // 内容部分
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 打开目录按钮
        secondaryIconButton(
          context,
          label: const Text('打开目录'),
          icon: Icons.folder,

          // 执行逻辑
          onPressed: () {
            // 调用开启目录方法
            controller.getFile();
          },
        ),

        // 右侧操作区域
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 批量操作按钮
            borderButton(
              context,
              label: const Text('批量操作'),

              // 执行逻辑
              onPressed: () {
                print('object');
              },
            ),

            // 开始修改按钮
            const Padding(padding: EdgeInsets.all(11)),
            primaryIconButton(
              context,
              label: const Text('开始修改'),
              icon: Icons.east_rounded,
              iconPosition: 'right',

              // 执行逻辑
              onPressed: () {
                print('object');
              },
            ),
          ],
        ),
      ],
    ),
  );
}
