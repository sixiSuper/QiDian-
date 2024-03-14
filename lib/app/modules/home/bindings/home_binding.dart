import 'package:get/get.dart';

import '../controllers/home_controller.dart';

import '../../../components/home/body/body_controller.dart';
import '../../../components/home/bulkOperations/bulkOperations_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    /* 首页 */ Get.lazyPut<HomeController>(() => HomeController());
    /* 表格组件控制器 */ Get.lazyPut<BodyController>(() => BodyController());
    /* 批量操作页面控制器 */ Get.lazyPut<BulkOperationsController>(() => BulkOperationsController());
  }
}
