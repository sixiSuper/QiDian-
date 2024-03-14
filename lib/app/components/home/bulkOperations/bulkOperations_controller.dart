// ...
// 批量操作弹窗页面控制器
// ...

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../general/toast/toast.dart';
import 'package:excel/excel.dart';
import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';

class BulkOperationsController extends GetxController {
  BuildContext context = Get.context!;
  // 下载的文件路径
  RxString downloadedPath = ''.obs;
  // 上传的文件路径
  RxString selectedPath = ''.obs;
  // 上传的文件名称
  RxString selectedName = ''.obs;

  /// 自定义方法：下载模板
  void downloadTemplate() async {
    // top.1 选择下载路径
    String? path = await getDirectoryPath();

    // 1.1 将选择到的路径传给 downloadedPath
    if (path != null) downloadedPath.value = path;

    // top.2 生成模板
    Excel excel = Excel.createExcel();

    // top.3 生成模板数据
    Sheet sheet = excel['Sheet1'];

    // 3.1 第一行提示内容
    sheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
      const TextCellValue('温馨提示：请在标 [ *重命名 ] 一栏填写文件名称（空置将默认输出原名）'),
      // 样式
      cellStyle: CellStyle(
        fontColorHex: 'FFFF0000',
        fontSize: 16,
        bold: true,
      ),
    );

    // 3.1 第二行表头

    // 3.2 生成所有数据

    // top.4 下载模板

    // 4.1 检测该路径下已有几个模板
    int templateCount = 0;
    Stream<FileSystemEntity> fileList = Directory(downloadedPath.value).list();

    // 创建循环，遍历模板数量
    await for (FileSystemEntity fileSystemEntity in fileList) {
      String name = fileSystemEntity.path.substring('${downloadedPath.value}1'.length);
      // print(name);
      if (fileSystemEntity is! Directory) {
        if (name.substring(0, 15) == '模板：批量重命名_QiDian') templateCount++;
      }
    }

    // 4.2 下载新模板
    var fileBytes = excel.save();
    File('${downloadedPath.value}${Platform.pathSeparator}模板：批量重命名_QiDian${templateCount == 0 ? '' : '~$templateCount'}.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    // 4.3 提示已下载
    // ignore: use_build_context_synchronously
    showToast(
      context,
      '文件已下载至：${downloadedPath.value}${Platform.pathSeparator}模板：批量重命名_QiDian${templateCount == 0 ? '' : '~$templateCount'}.xlsx',
      toastDuration: 5,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
