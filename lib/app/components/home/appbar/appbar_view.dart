// ...
// 顶部导航栏（包含窗口操作按钮）
// ...

import 'package:bulk_renaming_flutter/app/components/general/alertDialog/dialogView_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
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
            Row(children: [
              // 设置按钮
              IconButton(
                // 隐藏反馈效果
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,

                icon: Icon(
                  Icons.menu,
                  size: 24,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                onPressed: () {
                  dialogView(
                    context,
                    // 内容
                    child: SizedBox(
                        width: 480,
                        height: 600,
                        child: Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            header(context),
                            const SizedBox(height: 30),
                            const Text('版本号：v1.0.0'),
                            const SizedBox(height: 10),
                            Row(children: [
                              const Text('本项目使用'),
                              InkWell(
                                child: const Text(' MulanPSL-2.0 '),
                                onTap: () async {
                                  Uri url = Uri.parse('http://license.coscl.org.cn/MulanPSL2');
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                              ),
                              const Text('开源协议，请自觉遵守相关条例。'),
                            ]),
                            const SizedBox(height: 30),
                            const Text('相关网址', style: TextStyle(fontWeight: FontWeight.w500)),
                            const SizedBox(height: 10),
                            Row(children: [
                              const Text('getee：'),
                              InkWell(
                                child: const Text('https://gitee.com/sixiSuper/qidian-file-manager.git'),
                                onTap: () async {
                                  Uri url = Uri.parse('https://gitee.com/sixiSuper/qidian-file-manager.git');
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                              ),
                            ]),
                            const SizedBox(height: 10),
                            Row(children: [
                              const Text('gethub：'),
                              InkWell(
                                child: const Text('https://github.com/sixiSuper/QiDian-File-Manager.git'),
                                onTap: () async {
                                  Uri url = Uri.parse('https://github.com/sixiSuper/QiDian-File-Manager.git');
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                              ),
                            ]),
                          ]),
                        )),
                  );
                },
              ),

              // 标题
              const SizedBox(width: 10),
              const Text(
                'QiDian',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: '微软雅黑',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(31, 41, 55, 1),
                ),
              ),
            ]),
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

// 抬头区域
Widget header(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('关于',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onPrimary,
          )),

      // 关闭按钮
      IconButton(
        // 隐藏反馈效果
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,

        // 点击事件
        onPressed: () {
          Navigator.pop(context, false);
        },
        icon: Icon(
          Icons.clear_rounded,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 24,
        ),
      ),
    ],
  );
}
