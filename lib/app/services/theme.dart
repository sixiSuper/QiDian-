// 主题文件 (关于flutter主题的详细介绍可查看：https://book.flutterchina.club/chapter7/theme.html#_7-4-2-%E4%B8%BB%E9%A2%98-theme)

import 'package:flutter/material.dart';
import './color/colorPalette.dart';

// Top.1 主题
class AppTheme {
  // 浅色主题
  static ThemeData lightTheme() {
    return ThemeData(
        fontFamily: 'MiSans',
        splashColor: Colors.transparent, // 点击背景水波纹效果设为透明

        // 文字主题
        textTheme: const TextTheme(
            // bodyLarge: TextStyle(color: QiColor.gray()),
            // bodyMedium: TextStyle(color: QiColor.gray()),
            // bodySmall: TextStyle(color: QiColor.gray()),
            ),

        // App 导航栏
        appBarTheme: const AppBarTheme(
          // backgroundColor: QiColor.backgroundColor(), // 背景色

          // 设置图标样式
          iconTheme: IconThemeData(
              // color: QiColor.gray(), // 设置图标颜色
              ),
        ),

        // 按钮样式
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith((states) => QiColor.gray()), // 设置按钮文字颜色
          ),
        ),

        // 底部导航栏
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0, // 取消底部导航栏的阴影
          backgroundColor: Colors.white, // 底部导航栏背景色
          // selectedItemColor: QiColor.primary(), // 被选中的颜色
          unselectedItemColor: QiColor.gray(levels: 4), // 未选中的颜色
        ),

        // 卡片样式
        cardTheme: const CardTheme(
          shadowColor: Color.fromRGBO(0, 0, 0, 0.05), // 阴影颜色
        ),
        cardColor: QiColor.gray(levels: 1), // 代用于：分割线颜色

        // 底部浮动按钮
        floatingActionButtonTheme: const FloatingActionButtonThemeData(),

        // 色彩大全
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: QiColor.primary(), // 主要色
          secondary: QiColor.safety(), // 次要色
          primaryContainer: Colors.white, // 主要容器背景色
          secondaryContainer: Colors.black, // 次要容器背景色
          background: QiColor.backgroundColor(), // 主要背景色
          error: QiColor.emphasize(levels: 4), // 错误色
          onBackground: QiColor.emphasize(),
          onError: QiColor.warning(),
          onPrimary: QiColor.gray(), // 主要字体颜色
          onSecondary: QiColor.gray(levels: 3), // 次要字体颜色
          onSurface: QiColor.gray(), // 标题字体色
          surface: QiColor.backgroundColor(), // 标题字体色背景（appBar背景色）
        ));
  }

  // 深色主题
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.light, // 深色主题
    );
  }
}
