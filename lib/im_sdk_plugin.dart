import 'package:flutter/services.dart';
import 'manager/im_manager.dart';

/// IM SDK 插件入口类
class ImSDKPlugin {
  /// 通信管道，用于与原生平台交互
  static const MethodChannel _channel = MethodChannel('im_sdk_plugin');

  /// IM 管理器实例
  static IMManager? manager;

  /// 获取 IM 管理器实例
  ///
  /// 如果实例为空，则创建一个新的实例
  static IMManager managerInstance() {
    manager ??= IMManager(_channel);
    return manager!;
  }

  /// 公开的静态访问点，用于获取 IMManager
  static IMManager v2TIMManager = ImSDKPlugin.managerInstance();
}
