// ...
// 自定义表格
// ...

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../models/home/filesListTime.dart';
import '../../general/textInput/textInput_view.dart';
import '../body/body_controller.dart';

Widget table(
  BuildContext context,
  RxList<FilesListTime> filesList, {
  String filePath = '未打开',
}) {
  double tableHeaderHightSize = 50;
  // 页眉文字统一样式
  TextStyle tableHeaderTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onSecondary,
    overflow: TextOverflow.ellipsis,
  );

  // 内容
  return Column(children: [
    // 表头
    Container(
        height: tableHeaderHightSize,
        // 容器样式
        decoration: BoxDecoration(
          // 边框
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.5),
            ),
          ),
        ),
        // 内边距
        padding: const EdgeInsets.symmetric(horizontal: 10),

        // 容器内容
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 左侧内容
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 文件类型
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text('文件类型', style: tableHeaderTextStyle),
                  ),

                  // 文件名称
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      width: 1000,
                      child: Text('文件名称', style: tableHeaderTextStyle),
                    ),
                  ),

                  // 文件格式
                  SizedBox(width: 80, child: Text('文件格式', style: tableHeaderTextStyle)),
                ],
              ),
            ),

            // 自定义重命名输入框
            Container(
              margin: const EdgeInsets.only(left: 80),
              width: 300,
              child: Text('重命名', style: tableHeaderTextStyle),
            ),
          ],
        )),

    // 表格内容
    Flexible(
      child: Container(
        padding: const EdgeInsets.only(top: 5),

        // 列表
        child: ListView.builder(
          itemCount: filesList.length,
          itemBuilder: (context, index) => TableRow(
            key: ValueKey('${filesList[index].fileName}.${filesList[index].fileFormat}'),
            index: index,
          ),
        ),
      ),
    ),

    // 页脚：展示文件夹路径
    Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(10),
      child: Text('当前目录：${filePath == '' ? '无' : filePath}'),
    ),
  ]);
}

// 列表行组件
class TableRow extends GetView<BodyController> {
  // 构造函数
  const TableRow({
    Key? key,
    required this.index,
  }) : super(key: key);

  /// 序列
  final int index;

  @override
  Widget build(BuildContext context) {
    // 页眉文字统一样式
    TextStyle tableHeaderTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
      overflow: TextOverflow.ellipsis,
    );

    // 获取文件信息
    FilesListTime file = controller.allFilesList[index];
    // print(file.invalidFormat);

    // 判断是否为视频
    bool isVideo = file.fileFormat == 'avi' || file.fileFormat == 'mov' || file.fileFormat == 'mp4' || file.fileFormat == 'mpg' || file.fileFormat == 'mpeg' || file.fileFormat == 'mpe' || file.fileFormat == 'dat' || file.fileFormat == 'vob' || file.fileFormat == 'asf' || file.fileFormat == '3gp' || file.fileFormat == 'wmv' || file.fileFormat == 'asf' || file.fileFormat == 'flv' || file.fileFormat == 'mkv';

    // 判断是否为图片
    bool isImage = file.fileFormat == 'jpg' || file.fileFormat == 'png' || file.fileFormat == 'jpeg' || file.fileFormat == 'gif' || file.fileFormat == 'bmp' || file.fileFormat == 'tif' || file.fileFormat == 'tiff' || file.fileFormat == 'ico' || file.fileFormat == 'svg';

    // 内容
    return Container(
      // 内边距
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 0.5,
        color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.2),
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧内容
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 文件类型(图标)
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Icon(
                      file.folder
                          ? Icons.folder
                          : isVideo
                              ? Icons.video_collection_rounded
                              : isImage
                                  ? Icons.photo
                                  : Icons.article_rounded,
                      size: 24,
                      color: file.folder
                          ? Colors.yellow[700]
                          : isVideo || isImage
                              ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                              : Theme.of(context).colorScheme.onSecondary.withOpacity(0.8),
                    ),
                  ),

                  // 文件名称
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      width: 1000,
                      child: Text(file.fileName, style: tableHeaderTextStyle),
                    ),
                  ),

                  // 文件格式
                  SizedBox(width: 80, child: Text('.${file.fileFormat}', style: tableHeaderTextStyle)),
                ],
              ),
            ),
          ),

          // 自定义重命名输入框
          Container(
            margin: const EdgeInsets.only(left: 80, top: 4, bottom: 4),
            width: 300,
            child: textInput(
              context,
              error: controller.allFilesList[index].isRepeat || controller.allFilesList[index].invalidFormat,
              errorText: controller.allFilesList[index].invalidFormat ? '文件名不能包含字符：${Platform.pathSeparator} / : * ? " < > |' : '请勿输入重复名称',

              // 输入时执行
              onChanged: (text) {
                bool invalidFormat0 = false; // 格式错误

                // top.1 遍历输入文字中是否存在禁用字符
                for (int i = 0; i < text.length; i++) {
                  if (text[i] == Platform.pathSeparator || text[i] == '/' || text[i] == ':' || text[i] == '*' || text[i] == '?' || text[i] == '"' || text[i] == '<' || text[i] == '>' || text[i] == '|') {
                    invalidFormat0 = true;
                    break;
                  }
                }

                // 判断并同步格式错误
                if (invalidFormat0) {
                  controller.changeValue(index, invalidFormat: invalidFormat0);
                  return;
                } else {
                  controller.changeValue(index, invalidFormat: invalidFormat0);
                }

                // 传入内容
                controller.changeValue(index, newName: text);

                // top.2 遍历列表中是否有重名的文件
                for (int i = 0; i < controller.allFilesList.length; i++) {
                  bool indexNotRepeat = true; // 序列 index 的名称不重复状态
                  // 如果找到重复名称的文件，把他和当前文件一同标记出来
                  if (i != index && controller.allFilesList[i].newFileName == text && text != '' && controller.allFilesList[i].fileFormat == controller.allFilesList[index].fileFormat) {
                    controller.changeValue(i, isRepeat: true);
                    controller.changeValue(index, isRepeat: true);
                    indexNotRepeat = false;
                  }

                  if (indexNotRepeat) {
                    // 否则如果发现列表中存在被标记为重复的文件
                    if (controller.allFilesList[i].isRepeat) {
                      bool iNotRepeat = true; // 序列 i 的名称不重复状态

                      // 遍历查找是否有其他重复文件
                      for (int j = 0; j < controller.allFilesList.length; j++) {
                        if (j != index && j != i && controller.allFilesList[i].newFileName == controller.allFilesList[j].newFileName && controller.allFilesList[i].fileFormat == controller.allFilesList[j].fileFormat) {
                          iNotRepeat = false;
                        }
                      }

                      // 确认不重复，取消标记
                      if (iNotRepeat) controller.changeValue(i, isRepeat: false);
                    }
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
