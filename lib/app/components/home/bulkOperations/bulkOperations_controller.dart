// ...
// 批量操作弹窗页面控制器
// ...

import 'package:get/get.dart';

class BulkOperationsController extends GetxController {
  // 选择的文件路径
  RxString selectedPath = ''.obs;
  // 选择的文件名称
  RxString selectedName = ''.obs;
}
