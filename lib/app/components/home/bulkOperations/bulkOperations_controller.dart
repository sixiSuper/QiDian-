// ...
// 批量操作弹窗页面控制器
// ...

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

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

  /// 自定义方法：生成与下载模板
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
      sheet.setColumnWidth(1, 15);
      sheet.setColumnWidth(2, 40);
      sheet.setColumnWidth(3, 15);
      sheet.setColumnWidth(4, 100);
      // 行高
      sheet.setRowHeight(0, 20);
      sheet.setRowHeight(1, 20);
      sheet.setRowHeight(2, 20);
      sheet.setRowHeight(3, 20);
      sheet.setRowHeight(4, 20);

      // 3.2 第一行提示内容
      // 合并单元格
      sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('E1'));
      sheet.merge(CellIndex.indexByString('A2'), CellIndex.indexByString('E2'));
      sheet.merge(CellIndex.indexByString('A3'), CellIndex.indexByString('E3'));
      sheet.merge(CellIndex.indexByString('A4'), CellIndex.indexByString('E4'));
      // 填写内容
      setCell(
        sheet,
        'A1',
        '温馨提示：请在标 [ *文件名称（重命名） ] 一栏填写文件名称（空置将默认输出原名），其余内容请勿修改',
        fontColorHex: 'FFC00000',
        fontSize: 11,
        bold: true,
      );
      setCell(
        sheet,
        'A2',
        '—————文件名不能包含字符：${Platform.pathSeparator} / : * ? " < > |',
        fontColorHex: 'FFC00000',
        fontSize: 11,
        bold: true,
      );
      setCell(
        sheet,
        'A3',
        '—————请勿输入重复名称',
        fontColorHex: 'FFC00000',
        fontSize: 11,
        bold: true,
      );

      // 3.3 第二行表头
      setCell(sheet, 'A5', '行号', bold: true, horizontalAlign: HorizontalAlign.Center);
      setCell(sheet, 'B5', '文件类型', bold: true);
      setCell(sheet, 'C5', '文件名称（原）', bold: true);
      setCell(sheet, 'D5', '文件格式', bold: true);
      setCell(sheet, 'E5', '文件名称（重命名）', bold: true, fontColorHex: 'FFFF0000');

      // 3.4 生成所有数据
      for (int i = 0; i < allFilesList.length; i++) {
        String classify = allFilesList[i].folder ? '文件夹' : '文件'; // 判断文件类型

        // 插入行号
        setCell(sheet, 'A1', '${i + 1}', columnIndex: 0, rowIndex: i + 5, intValue: i + 1, horizontalAlign: HorizontalAlign.Center);
        // 插入文件类型
        setCell(sheet, 'A1', classify, columnIndex: 1, rowIndex: i + 5);
        // 插入文件名称
        setCell(sheet, 'A1', allFilesList[i].fileName, columnIndex: 2, rowIndex: i + 5);
        // 插入文件格式
        setCell(sheet, 'A1', '.${allFilesList[i].fileFormat}', columnIndex: 3, rowIndex: i + 5);
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
    int? intValue,
    HorizontalAlign horizontalAlign = HorizontalAlign.Left, // 水平对齐方式
  }) {
    sheet.updateCell(
      columnIndex != null && rowIndex != null ? CellIndex.indexByColumnRow(columnIndex: columnIndex, rowIndex: rowIndex) : CellIndex.indexByString(indexByString),
      intValue == null ? TextCellValue(value) : IntCellValue(intValue),
      cellStyle: CellStyle(
        fontColorHex: fontColorHex,
        fontSize: fontSize,
        bold: bold,
        verticalAlign: VerticalAlign.Center,
        horizontalAlign: horizontalAlign,
      ),
    );
  }

  /// 自定义方法：上传模板
  void uploadTemplate() async {
    // top.1 获取文件路径

    // 1.1 定义一个用于读取 excel 文件的 XTypeGroup 对象
    const xType = XTypeGroup(label: '表格', extensions: ['xls', 'xlsx']);
    // 1.2 弹窗获取文件路径
    XFile? file = await openFile(acceptedTypeGroups: [xType]);
    // 1.3 将文件路径和名字传入预设属性中
    if (file != null) {
      selectedPath.value = file.path;
      selectedName.value = file.name;
    }
  }

  /// TODO 自定义方法：模板数据上传
  void uploadData() async {
    // top.1 读取数据

    // 1.1 将 excel 文件转换为字节码数据
    var bytes = File(selectedPath.value).readAsBytesSync();
    // 1.2 将字节码数据实例化为可读取的 excel 对象
    var excel = SpreadsheetDecoder.decodeBytes(bytes);
    var table = excel.tables['Sheet1'];
    print(table!.maxRows);

    // 循环表格每一行数据
    for (int i = 0; i < table.maxRows; i++) {
      // 跳过前五行，进入正式数据行
      if (i >= 5) {
        // 如果当前列的重命名一栏不为空，则在列表中找到对应的数据，并将数据全部填入列表之中
        if (table.rows[i][4] != null) {
          for (int j = 0; j < allFilesList.length; j++) {
            if (allFilesList[j].fileName == table.rows[i][2] && '.${allFilesList[j].fileFormat}' == table.rows[i][3]) {
              // 判断名称中是否带有异常字符
              bool hasInvalidChars = !RegExp(r'[^\\/:*?"<>|]').hasMatch(table.rows[i][4]);

              // 判断名称是否与其他名称重复
              bool isRepe = false;
              for (int k = 0; k < table.maxRows; k++) {
                if (k != i && table.rows[k][4] == table.rows[i][4] && table.rows[k][3] == table.rows[i][3]) {
                  isRepe = true;
                  break;
                }
              }

              // 数据赋值给 allFilesList，完成数据上传
              allFilesList[j] = FilesListTime.fromJson({
                'folder': allFilesList[j].folder,
                'fileName': allFilesList[j].fileName,
                'fileFormat': allFilesList[j].fileFormat,
                'newFileName': table.rows[i][4],
                'isRepeat': isRepe,
                'invalidFormat': hasInvalidChars,
              });
            }
          }
        }
      }
    }

    // 上传成功
    selectedPath.value = '';
    showToast(context, '上传成功');
  }
}
