import 'package:get/get.dart';

import '../controllers/home_controller.dart';

import '../../../components/home/body/body_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    /* 首页 */ Get.lazyPut<HomeController>(() => HomeController());
    /* 自定义表格组件 */ Get.lazyPut<BodyController>(() => BodyController());
  }
}
