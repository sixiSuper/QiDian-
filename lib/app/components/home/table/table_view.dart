// ...
// 自定义表格
// ...

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../models/home/filesListTime.dart';

Widget table(BuildContext context, RxList<FilesListTime> filesList, {String filePath = '未打开', Function? changeName}) {
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
    Obx(() => Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 15),

            // 列表
            child: ListView.builder(
              itemCount: filesList.length,
              itemBuilder: (context, index) => tableRow(
                context,
                folder: filesList[index].folder,
                fileName: filesList[index].fileName,
                fileFormat: filesList[index].fileFormat,
                index: index,
                changeName: changeName,
              ),
            ),
          ),
        )),

    // 页脚：展示文件夹路径
    Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(10),
      child: Text('当前目录：${filePath == '' ? '无' : filePath}'),
    )
  ]);
}

// 列表行组件
Widget tableRow(
  BuildContext context, {
  /// 是否为文件夹
  bool folder = false,

  /// 文件名称
  String fileName = '文件名称',

  /// 文件格式
  String fileFormat = '格式',

  /// 序列
  int index = 0,

  /// 同步新名称方法
  Function? changeName,
}) {
  // 行高度
  double tableHeaderHightSize = 40;

  // 页眉文字统一样式
  TextStyle tableHeaderTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
    overflow: TextOverflow.ellipsis,
  );

  // 判断是否为视频
  bool isVideo = fileFormat == 'avi' || fileFormat == 'mov' || fileFormat == 'mp4' || fileFormat == 'mpg' || fileFormat == 'mpeg' || fileFormat == 'mpe' || fileFormat == 'dat' || fileFormat == 'vob' || fileFormat == 'asf' || fileFormat == '3gp' || fileFormat == 'wmv' || fileFormat == 'asf' || fileFormat == 'flv' || fileFormat == 'mkv';

  // 判断是否为图片
  bool isImage = fileFormat == 'jpg' || fileFormat == 'png' || fileFormat == 'jpeg' || fileFormat == 'gif' || fileFormat == 'bmp' || fileFormat == 'tif' || fileFormat == 'tiff' || fileFormat == 'ico' || fileFormat == 'svg';

  // 内容
  return Container(
      height: tableHeaderHightSize,
      // 内边距
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 左侧内容
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 文件类型(图标)
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: Icon(
                    folder
                        ? Icons.folder
                        : isVideo
                            ? Icons.video_collection_rounded
                            : isImage
                                ? Icons.photo
                                : Icons.article_rounded,
                    size: 24,
                    color: folder
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
                    child: Text(fileName, style: tableHeaderTextStyle),
                  ),
                ),

                // 文件格式
                SizedBox(width: 80, child: Text('.$fileFormat', style: tableHeaderTextStyle)),
              ],
            ),
          ),

          // 自定义重命名输入框
          Container(
            margin: const EdgeInsets.only(left: 80, top: 4, bottom: 4),
            width: 300,
            padding: const EdgeInsets.all(6),
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.grey, width: 1),
            //   borderRadius: BorderRadius.circular(5),
            // ),
            child: TextField(
                decoration: InputDecoration(
                  hintText: '请输入新文件名，空置代表使用原名称',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 18),
                  alignLabelWithHint: true,
                ),

                // 监听输入内容
                onChanged: (text) {
                  changeName!(text, index);
                  print(text);
                }),
          ),
        ],
      ));
}
