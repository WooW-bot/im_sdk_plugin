import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';

import 'config/config.dart';
import 'i18n/strings.g.dart';
import 'index/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 1. 初始化，根据设备语言自动选择，如果是 Web 或测试，这也很有用
  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: const APIExampleApp())); // 2. 包裹 App
}

class APIExampleApp extends StatelessWidget {
  const APIExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 3. 配置本地化代理
      locale: TranslationProvider.of(context).flutterLocale,
      // 监听语言变化
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      showPerformanceOverlay: true,
      home: const Index(),
      title: Config.appName,
      builder:   EasyLoading.init(),
    );
  }
}
