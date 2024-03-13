import 'dart:io';

import 'package:bulk_renaming_flutter/app/components/general/alertDialog/alertDialog_view.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import '../../../models/home/filesListTime.dart';

class HomeController extends GetxController with WindowListener {
  BuildContext? context; // 获取主体
  RxBool isMaximized = false.obs; // 是否最大化
  RxString filePath = ''.obs; // 文件路径

  /// 列表刷新计数
  RxInt listRefreshCount = 0.obs;

  // 所有文件的列表
  RxList<FilesListTime> allFilesList = <FilesListTime>[].obs;

  @override
  void onInit() {
    super.onInit();
    // 监听关闭事件
    windowManager.addListener(this);
    _init();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {
    super.onClose();
    // 销毁关闭事件监听
    windowManager.removeListener(this);
  }

  // 关闭窗口事件
  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    // 如果执行了关闭事件
    if (isPreventClose) {
      // 如果当前窗口为最小化状态，则恢复窗口以起到提醒作用
      bool isMinimized = await windowManager.isMinimized();
      if (isMinimized) {
        windowManager.restore();
      }

      // 监听确认框执行情况，如果点击了确认则真正关闭软件
      bool popUpResults = await alertDialog(
        context!,
        title: '确认关闭',
        content: '关闭后无法保存正在编辑的内容，请确认关闭',
      );
      if (popUpResults) windowManager.destroy();
    }
  }

  // 窗口最大化事件
  @override
  void onWindowResize() async {
    bool isMaximized = await windowManager.isMaximized();
    this.isMaximized.value = isMaximized;

    print('isMaximized: $isMaximized');
  }

  // 窗口恢复事件1
  @override
  void onWindowMaximize() async {
    bool isMaximized = await windowManager.isMaximized();
    this.isMaximized.value = isMaximized;

    print('isMaximized: $isMaximized');
  }

  // 窗口恢复事件2
  @override
  void onWindowUnmaximize() async {
    bool isMaximized = await windowManager.isMaximized();
    this.isMaximized.value = isMaximized;

    print('isMaximized: $isMaximized');
  }

  /// 自定义方法：运行软件关闭时被截停并处理
  void _init() async {
    // 添加此行以覆盖默认关闭处理程序
    await windowManager.setPreventClose(true);
  }

  /// 自定义方法：获取 context
  void getContext(BuildContext context) {
    this.context = context;
  }

  /// 自定义方法：窗口最大化/正常化状态变更
  void toggleMaximize() {
    isMaximized.value = !isMaximized.value;
  }

  /// 自定义方法：获取本地文件目录
  void getFile() async {
    print('打开了目录选择器');
    final String? path = await getDirectoryPath();
    if (path != null) {
      // print('path: $path');

      // 传入选中的路径
      filePath.value = path;
      // 刷新列表数据
      listRefreshCount.value++;
    }
  }

  /// TODO 自定义方法：文件重命名
  void renameFile() async {
    /// 循环列表，将每个文件重命名并写入新文件夹中
    for (int i = 0; i < allFilesList.length; i++) {
      if (allFilesList[i].fileName != allFilesList[i].newFileName) {
        // 获取后缀名
        var format = allFilesList[i].fileFormat == '' ? '' : '.${allFilesList[i].fileFormat}';

        // 重命名文件
        if (allFilesList[i].folder) {
          // 重命名类型是文件夹
          var oldFile = Directory('${filePath.value}${Platform.pathSeparator}${allFilesList[i].fileName}$format'); // 文件夹
          var file = await oldFile.rename('${filePath.value}${Platform.pathSeparator}${allFilesList[i].newFileName}$format');
          // 让页面刷新一下
          listRefreshCount.value++;

          // 输出结果
          print('${file.path}${Platform.pathSeparator} 文件夹重命名成功');
        } else {
          // 重命名类型是文件
          var oldFile = File('${filePath.value}${Platform.pathSeparator}${allFilesList[i].fileName}$format'); // 文件夹
          var file = await oldFile.rename('${filePath.value}${Platform.pathSeparator}${allFilesList[i].newFileName}$format');
          // 动一动路径，让页面刷新一下
          listRefreshCount.value++;

          // 输出结果
          print('${file.path}${Platform.pathSeparator} 文件重命名成功');
        }
      }
    }
  }
}
