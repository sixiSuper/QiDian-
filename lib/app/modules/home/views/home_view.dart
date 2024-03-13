import 'package:bulk_renaming_flutter/app/components/home/Title/pageTitle_view.dart';
import 'package:bulk_renaming_flutter/app/components/home/body/body_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/home/appbar/appbar_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getContext(context);
    return Scaffold(
        // 导航栏
        appBar: appbar(context, controller),

        // 内容部分
        body: Obx(() => Column(
              children: [
                pageTitle(context, controller), // 页眉部分（几个主要操作按钮）
                // 表格内容部分
                BodyView.filePath(controller.filePath.value, controller.listRefreshCount.value, (e) {
                  // 将子组件得到的列表值传给父组件
                  controller.allFilesList.value = e;
                  print('向父组件传值成功，第一个文件/文件夹名称：${e[0].newFileName}');
                }), // 主体内容部分
              ],
            )));
  }
}
