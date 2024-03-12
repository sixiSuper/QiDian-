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
        body: Column(
          children: [
            pageTitle(context), // 页眉部分
            body(context), // 主体内容部分
          ],
        ));
  }
}
