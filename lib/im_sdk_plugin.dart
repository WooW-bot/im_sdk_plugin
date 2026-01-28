export 'package:im_sdk_core/im_sdk_core.dart';
export 'package:im_sdk_plugin/listener/im_sdk_listener.dart';

import 'manager/im_manager.dart';

/// IM SDK 插件入口类
class ImSDKPlugin {
  /// IM 管理器实例
  static IMManager? manager;

  /// 获取 IM 管理器实例
  ///
  /// 如果实例为空，则创建一个新的实例
  static IMManager managerInstance() {
    manager ??= IMManager();
    return manager!;
  }

  /// 公开的静态访问点，用于获取 IMManager
  static IMManager imManager = ImSDKPlugin.managerInstance();
}
