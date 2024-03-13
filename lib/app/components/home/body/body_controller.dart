import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/home/filesListTime.dart';

class BodyController extends GetxController {
  // 文件夹列表
  RxList<FilesListTime> directoryList = <FilesListTime>[].obs;
  // 文件列表
  RxList<FilesListTime> filesList = <FilesListTime>[].obs;
  // 合并列表
  RxList<FilesListTime> allFilesList = <FilesListTime>[].obs;

  ValueChanged<List<FilesListTime>>? changeColorCallBack;

  // 文件路径
  RxString filePath = ''.obs;
  RxInt listRefreshCount = 0.obs;

  @override // 生命周期：初始化
  void onInit() {
    super.onInit();

    // 监听路径变化并及时获取文件列表
    ever(listRefreshCount, (_) {
      if (filePath.value != '') {
        getFilesList();
      }
    });
  }

  @override // 生命周期：启动完成
  void onReady() {
    super.onReady();
    print(filePath.value);
  }

  /// 自定义方法：获取文件夹下所有文件列表
  void getFilesList() async {
    // 清空两大列表
    directoryList.clear();
    filesList.clear();

    /// 路径长度 (用于读取目录内容时减去前缀路径，获取真正的文件名称)
    int filePathLength = filePath.value.length;

    // 读取目录内容
    Stream<FileSystemEntity> fileList = Directory(filePath.value).list();

    // 循环遍历目录内容
    await for (FileSystemEntity fileSystemEntity in fileList) {
      // 截取文件名称
      String myFileName = fileSystemEntity.path.substring(filePathLength + 1);

      // 判断文件是否为 [desktop.ini]，如果是的话直接跳过这一项
      if (myFileName != 'desktop.ini') {
        // 正常文件，执行处理程序
        // 创建数据对象，待上传至 [filesList] 列表
        Map filesListTime = {
          'folder': false,
          'fileName': '',
          'fileFormat': '',
        };

        // 判断是否为文件夹
        if (fileSystemEntity is Directory) {
          filesListTime['folder'] = true;
          // 文件夹无后缀名，名称直接传即可
          filesListTime['fileName'] = myFileName;

          // 将该文件夹信息传入文件夹列表中
          directoryList.add(FilesListTime.fromJson(filesListTime));
        } else {
          // 传入文件名称
          filesListTime['fileName'] = myFileName.split('.')[0];
          // 传入后缀名
          filesListTime['fileFormat'] = myFileName.split('.')[1];

          // 将该文件信息传入文件列表中
          filesList.add(FilesListTime.fromJson(filesListTime));
        }

        // 打印查看这次遍历的文件
        print(myFileName);
      }
    }

    // 创建临时数组
    List<FilesListTime> temporary = [];
    temporary.addAll(directoryList); // 合并文件夹列表
    temporary.addAll(filesList); // 合并文件列表

    // 更新文件列表
    allFilesList.value = temporary;
    changeColorCallBack!(allFilesList);
  }

  /// 自定义方法：修改新名称
  void changeName(String newName, index) {
    allFilesList[index].newFileName = newName;
    changeColorCallBack!(allFilesList);
    print('新名称同步成功：${allFilesList[index].newFileName}');
  }
}
