// ...
// 主体部分
// ...

import 'package:bulk_renaming_flutter/app/components/home/table/table_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/home/filesListTime.dart';
import '../../general/container/container.dart';
import './body_controller.dart';

class BodyView extends GetView<BodyController> {
  final String filePath;
  final int listRefreshCount;
  final ValueChanged<List<FilesListTime>> changeColorCallBack;
  const BodyView(this.changeColorCallBack, {Key? key, required this.filePath, required this.listRefreshCount}) : super(key: key);

  // 定义命名构造函数，从父组件获取“文件地址”数据
  const BodyView.filePath(this.filePath, this.listRefreshCount, this.changeColorCallBack, {super.key});

  @override
  Widget build(BuildContext context) {
    // 获取父元素尺寸
    final size = MediaQuery.of(context).size;
    controller.filePath.value = filePath;
    controller.listRefreshCount.value = listRefreshCount;
    controller.changeColorCallBack = changeColorCallBack;
    print('选择了文件目录：$filePath');

    return container(
      context,
      height: size.height - 167,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      // 调用表格组件实现内容展示
      child: table(
        context,
        controller.allFilesList, // 传入全部文件数据
        filePath: controller.filePath.value, // 传入目录路径
        changeName: controller.changeName, // 传入同步新名称方法
      ),
    );
  }
}
