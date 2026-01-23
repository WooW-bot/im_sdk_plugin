export 'package:im_sdk_core/core/models/im_custom_elem.dart';
export 'package:im_sdk_core/core/models/im_elem.dart';
export 'package:im_sdk_core/core/models/im_face_elem.dart';
export 'package:im_sdk_core/core/models/im_file_elem.dart';
export 'package:im_sdk_core/core/models/im_group_change_info.dart';
export 'package:im_sdk_core/core/models/sdk_context.dart';
export 'package:im_sdk_core/core/models/offline_push_info.dart';
export 'package:im_sdk_core/core/models/login_model.dart';
export 'package:im_sdk_core/core/models/im_video_elem.dart';
export 'package:im_sdk_core/core/models/im_value_callback.dart';
export 'package:im_sdk_core/core/models/im_user_full_info.dart';
export 'package:im_sdk_core/core/models/im_text_elem.dart';
export 'package:im_sdk_core/core/models/im_sound_elem.dart';
export 'package:im_sdk_core/core/models/im_message.dart';
export 'package:im_sdk_core/core/models/im_merger_elem.dart';
export 'package:im_sdk_core/core/models/im_location_elem.dart';
export 'package:im_sdk_core/core/models/im_image_elem.dart';
export 'package:im_sdk_core/core/models/im_image.dart';
export 'package:im_sdk_core/core/models/im_group_tips_elem.dart';
export 'package:im_sdk_core/core/models/im_group_member_info.dart';
export 'package:im_sdk_core/core/models/im_group_member_change_info.dart';
export 'package:im_sdk_core/core/models/im_group_info_result.dart';
export 'package:im_sdk_core/core/models/im_group_info.dart';
export 'package:im_sdk_core/core/models/im_callback.dart';


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
    manager ??= IMManager();
    return manager!;
  }

  /// 公开的静态访问点，用于获取 IMManager
  static IMManager imManager = ImSDKPlugin.managerInstance();
}
