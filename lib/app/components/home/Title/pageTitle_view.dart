// ...
// 页眉组件
// ...

import 'package:bulk_renaming_flutter/app/components/general/container/container.dart';
import 'package:flutter/material.dart';

import '../../general/alertDialog/alertDialog_view.dart';
import '../../general/button/button.dart';
import '../bulkOperations/bulkOperations_view.dart';

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
          onPressed: () async {
            // 如果列表不为空，则调用确认弹窗
            bool confirm = true;
            if (controller.allFilesList.isNotEmpty) {
              confirm = await alertDialog(
                context,
                title: '确认切换目录',
                content: '目录切换后，未保存的内容将会清空',
              );
            }

            // 确认后调用开启目录方法，进入选择界面
            if (confirm) controller.getFile();
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
                BulkOperations.bulkOperations(context);
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
                // 调用重命名文件方法
                controller.renameFile();
              },
            ),
          ],
        ),
      ],
    ),
  );
}
