import 'package:bulk_renaming_flutter/app/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //初始化 windowManager
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(720, 480), //设置窗口的最小尺寸
    // maximumSize: Size(800, 600), //设置窗口的最大尺寸
    //window 设置窗口的初始尺寸
    // size: Size(800, 500),
    //窗口是否居中
    // center: true,
    //设置窗口的背景色
    backgroundColor: Colors.transparent,
    //true 表示在状态栏不显示程序
    skipTaskbar: false,
    //true 表示设置Window一直位于最顶层
    alwaysOnTop: false,
    //hidden 表示隐藏标题栏 normal 显示标题栏
    titleBarStyle: TitleBarStyle.hidden,
    //设置窗口的标题，
    // title: "WindowSettingTest",
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    //显示窗口
    await windowManager.show();
    //聚焦窗口
    await windowManager.focus();
    //ture设置窗口不可缩放 false 设置窗口可以缩放
    windowManager.setResizable(true);
    //设置窗口缩放宽高比
    // windowManager.setAspectRatio(1.3);
    //设置窗口是否支持阴影
    windowManager.setHasShadow(true);
    //设置窗口模式：亮色模式和暗色模式
    // windowManager.setBrightness(Brightness.dark);
  });
  runApp(
    GetMaterialApp(
      themeMode: ThemeMode.system, // 主题模式
      theme: AppTheme.lightTheme(), // 浅色主题
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
