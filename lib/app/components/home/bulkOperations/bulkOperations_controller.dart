// ...
// 批量操作弹窗页面控制器
// ...

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/home/filesListTime.dart';
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
  // 所有文件的列表
  RxList<FilesListTime> allFilesList = <FilesListTime>[].obs;

  /// 自定义方法：下载模板
  void downloadTemplate() async {
    // top.1 选择下载路径
    String? path = await getDirectoryPath(confirmButtonText: '下载');

    // 1.1 将选择到的路径传给 downloadedPath
    if (path != null) {
      downloadedPath.value = path;
      // top.2 生成模板
      Excel excel = Excel.createExcel();

      // top.3 生成模板数据
      Sheet sheet = excel['Sheet1'];

      // 3.1 修改表格格式
      // 列宽
      sheet.setColumnWidth(0, 15);
      sheet.setColumnWidth(1, 40);
      sheet.setColumnWidth(2, 15);
      sheet.setColumnWidth(3, 100);
      // 行高
      sheet.setRowHeight(0, 40);
      sheet.setRowHeight(1, 20);

      // 3.2 第一行提示内容
      // 合并单元格
      sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('D1'));
      // 填写内容
      setCell(
        sheet,
        'A1',
        '温馨提示：请在标 [ *文件名称（重命名） ] 一栏填写文件名称（空置将默认输出原名），其余内容请勿修改',
        fontColorHex: 'FFC00000',
        fontSize: 11,
        bold: true,
      );

      // 3.3 第二行表头
      setCell(sheet, 'A2', '文件类型', bold: true);
      setCell(sheet, 'B2', '文件名称（原）', bold: true);
      setCell(sheet, 'C2', '文件格式', bold: true);
      setCell(sheet, 'C2', '文件名称（重命名）', bold: true, fontColorHex: 'FFFF0000');

      // TODO 3.4 生成所有数据
      for (int i = 0; i < allFilesList.length; i++) {
        String classify = allFilesList[i].folder ? '文件夹' : '文件'; // 判断文件类型

        // 插入文件类型
        setCell(sheet, 'A1', classify, columnIndex: 0, rowIndex: i + 2);
        // 插入文件名称
        setCell(sheet, 'A1', allFilesList[i].fileName, columnIndex: 1, rowIndex: i + 2);
        // 插入文件格式
        setCell(sheet, 'A1', '.${allFilesList[i].fileFormat}', columnIndex: 2, rowIndex: i + 2);
      }

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

  /// 自定义方法：插入单元格内容
  void setCell(
    Sheet sheet, // 表
    String indexByString, // 插入的单元格(A1)
    String value, // 插入内容
    {
    int? columnIndex, // 插入的单元格 列 坐标（空置时使用 indexByString）
    int? rowIndex, // 插入的单元格 行 坐标（空置时使用 indexByString）
    String fontColorHex = 'FF000000', // 字体颜色
    int fontSize = 12, // 字体大小
    bool bold = false, // 是否加粗
  }) {
    sheet.updateCell(
      columnIndex != null && rowIndex != null ? CellIndex.indexByColumnRow(columnIndex: columnIndex, rowIndex: rowIndex) : CellIndex.indexByString(indexByString),
      TextCellValue(value),
      cellStyle: CellStyle(
        fontColorHex: fontColorHex,
        fontSize: fontSize,
        bold: bold,
        verticalAlign: VerticalAlign.Center,
      ),
    );
  }
}
