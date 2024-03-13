// ...
// 自定义表格
// ...

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget table(BuildContext context) {
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

    // 内容
    Flexible(
      child: Container(
        padding: const EdgeInsets.only(top: 15),

        // 列表
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) => tableRow(context),
        ),
      ),
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
  FocusNode? focusNode,
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
                // 文件类型
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: Icon(
                    folder ? Icons.folder : Icons.article_rounded,
                    size: 24,
                    color: folder ? Colors.yellow[700] : Theme.of(context).colorScheme.onSecondary,
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
                floatingLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                hintTextDirection: TextDirection.ltr,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 18),
                alignLabelWithHint: true,
              ),
            ),
          ),
        ],
      ));
}
