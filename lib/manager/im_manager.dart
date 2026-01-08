import 'package:flutter/services.dart';

import '../enum/ImGroupListener.dart';
import '../enum/ImSDKListener.dart';
import '../enum/log_level_enum.dart';
import '../models/im_callback.dart';
import '../models/im_user_full_info.dart';
import '../models/im_user_status.dart';
import '../models/im_value_callback.dart';
import 'im_conversation_manager.dart';
import 'im_friendship_manager.dart';
import 'im_group_manager.dart';
import 'im_message_manager.dart';
import 'im_offline_push_manager.dart';

/// IM SDK 主核心管理类
abstract class IMManager {
  late MethodChannel _channel;

  IMManager(MethodChannel channel);

  /// 初始化 SDK
  ///
  /// [appID] 应用 ID
  /// [loglevel] 日志等级
  /// [listener] SDK 监听器
  /// [showImLog] 是否显示 IM 日志
  Future<ImValueCallback<bool>> initSDK({
    required int appID,
    required LogLevelEnum loglevel,
    required ImSDKListener listener,
    bool? showImLog = false,
  });

  /// 反初始化 SDK
  Future<ImCallback> unInitSDK();

  /// 登录
  ///
  /// [userID] 用户 ID
  /// [userSig] 用户签名
  Future<ImCallback> login({required String userID, required String userSig});

  /// 登出
  Future<ImCallback> logout();

  /// 获取当前登录用户
  Future<ImValueCallback<String>> getLoginUser();

  /// 获取登录状态
  Future<ImValueCallback<int>> getLoginStatus();

  /// 获取服务器时间
  Future<ImValueCallback<int>> getServerTime();

  /// 获取 SDK 版本
  Future<ImValueCallback<String>> getVersion();

  /// 获取会话管理器
  IMConversationManager getConversationManager();

  /// 获取关系链管理器
  IMFriendshipManager getFriendshipManager();

  /// 获取群组管理器
  IMGroupManager getGroupManager();

  /// 获取消息管理器
  IMMessageManager getMessageManager();

  /// 获取离线推送管理器
  IMOfflinePushManager getOfflinePushManager();

  /// 添加群组监听器
  Future<void> addGroupListener({required ImGroupListener listener});

  /// 移除群组监听器
  Future<void> removeGroupListener({ImGroupListener? listener});

  /// 加入群组
  Future<ImCallback> joinGroup({
    required String groupID,
    required String message,
    String? groupType,
  });

  /// 退出群组
  Future<ImCallback> quitGroup({required String groupID});

  /// 解散群组
  Future<ImCallback> dismissGroup({required String groupID});

  /// 获取用户资料
  Future<ImValueCallback<List<ImUserFullInfo>>> getUsersInfo({required List<String> userIDList});

  /// 获取用户状态
  Future<ImValueCallback<List<ImUserStatus>>> getUserStatus({required List<String> userIDList});

  /// 设置当前用户资料
  Future<ImCallback> setSelfInfo({required ImUserFullInfo userFullInfo});

  /// 设置当前用户状态
  Future<ImCallback> setSelfStatus({required String status});

  /// 设置 APNS 监听器
  Future setAPNSListener();
}
