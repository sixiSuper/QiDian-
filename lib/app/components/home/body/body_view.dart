// ...
// 主体部分
// ...

import 'package:bulk_renaming_flutter/app/components/home/table/table_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../general/container/container.dart';
import './body_controller.dart';

class BodyView extends GetView<BodyController> {
  const BodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取父元素尺寸
    final size = MediaQuery.of(context).size;

    return container(
      context,
      height: size.height - 167,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: table(context),
    );
  }
}
