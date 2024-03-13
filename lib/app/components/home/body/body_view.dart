// ...
// 主体部分
// ...

import 'package:bulk_renaming_flutter/app/components/home/table/table_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../general/container/container.dart';
import './body_controller.dart';

class BodyView extends GetView<BodyController> {
  final String filePath;
  const BodyView({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取父元素尺寸
    final size = MediaQuery.of(context).size;
    controller.filePath.value = filePath;
    print('选择了文件目录：$filePath');

    return container(
      context,
      height: size.height - 167,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: table(context, controller.allFilesList, filePath: controller.filePath.value),
    );
  }

  const BodyView.filePath(this.filePath, {super.key});
}
