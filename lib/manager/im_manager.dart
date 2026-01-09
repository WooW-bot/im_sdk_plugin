import 'package:flutter/services.dart';

import '../listener/im_group_listener.dart';
import '../listener/im_sdk_listener.dart';
import '../enums/log_level_enum.dart';
import '../models/im_callback.dart';
import '../models/im_user_full_info.dart';
import '../models/im_user_status.dart';
import '../models/im_value_callback.dart';
import 'im_conversation_manager.dart';
import 'im_offline_push_manager.dart';
import 'im_signaling_manager.dart';
import 'im_friendship_manager.dart';
import 'im_group_manager.dart';
import 'im_message_manager.dart';
import '../models/im_message.dart';

/// IM SDK 主核心管理类
class IMManager {
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
  }) async {
    // TODO: implement initSDK
    throw UnimplementedError();
  }

  /// 反初始化 SDK
  Future<ImCallback> unInitSDK() async {
    // TODO: implement unInitSDK
    throw UnimplementedError();
  }

  /// 登录
  ///
  /// [userID] 用户 ID
  /// [userSig] 用户签名
  Future<ImCallback> login({
    required String userID,
    required String userSig,
  }) async {
    // TODO: implement login
    throw UnimplementedError();
  }

  /// 登出
  Future<ImCallback> logout() async {
    // TODO: implement logout
    throw UnimplementedError();
  }

  /// 获取当前登录用户
  Future<ImValueCallback<String>> getLoginUser() async {
    // TODO: implement getLoginUser
    throw UnimplementedError();
  }

  /// 获取登录状态
  Future<ImValueCallback<int>> getLoginStatus() async {
    // TODO: implement getLoginStatus
    throw UnimplementedError();
  }

  /// 获取服务器时间
  Future<ImValueCallback<int>> getServerTime() async {
    // TODO: implement getServerTime
    throw UnimplementedError();
  }

  /// 获取 SDK 版本
  Future<ImValueCallback<String>> getVersion() async {
    // TODO: implement getVersion
    throw UnimplementedError();
  }

  /// 获取会话管理器
  IMConversationManager getConversationManager() {
    // TODO: implement getConversationManager
    throw UnimplementedError();
  }

  /// 获取关系链管理器
  IMFriendshipManager getFriendshipManager() {
    // TODO: implement getFriendshipManager
    throw UnimplementedError();
  }

  /// 获取群组管理器
  IMGroupManager getGroupManager() {
    // TODO: implement getGroupManager
    throw UnimplementedError();
  }

  /// 获取消息管理器
  IMMessageManager getMessageManager() {
    // TODO: implement getMessageManager
    throw UnimplementedError();
  }

  /// 获取离线推送管理器
  IMOfflinePushManager getOfflinePushManager() {
    // TODO: implement getOfflinePushManager
    throw UnimplementedError();
  }

  /// 添加群组监听器
  Future<void> addGroupListener({required ImGroupListener listener}) async {
    // TODO: implement addGroupListener
    throw UnimplementedError();
  }

  /// 移除群组监听器
  Future<void> removeGroupListener({ImGroupListener? listener}) async {
    // TODO: implement removeGroupListener
    throw UnimplementedError();
  }

  /// 加入群组
  Future<ImCallback> joinGroup({
    required String groupID,
    required String message,
    String? groupType,
  }) async {
    // TODO: implement joinGroup
    throw UnimplementedError();
  }

  /// 退出群组
  Future<ImCallback> quitGroup({required String groupID}) async {
    // TODO: implement quitGroup
    throw UnimplementedError();
  }

  /// 解散群组
  Future<ImCallback> dismissGroup({required String groupID}) async {
    // TODO: implement dismissGroup
    throw UnimplementedError();
  }

  /// 获取用户资料
  Future<ImValueCallback<List<ImUserFullInfo>>> getUsersInfo({
    required List<String> userIDList,
  }) async {
    // TODO: implement getUsersInfo
    throw UnimplementedError();
  }

  /// 获取用户状态
  Future<ImValueCallback<List<ImUserStatus>>> getUserStatus({
    required List<String> userIDList,
  }) async {
    // TODO: implement getUserStatus
    throw UnimplementedError();
  }

  /// 设置当前用户资料
  Future<ImCallback> setSelfInfo({required ImUserFullInfo userFullInfo}) async {
    // TODO: implement setSelfInfo
    throw UnimplementedError();
  }

  /// 设置当前用户状态
  Future<ImCallback> setSelfStatus({required String status}) async {
    // TODO: implement setSelfStatus
    throw UnimplementedError();
  }

  /// 设置 APNS 监听器
  Future setAPNSListener() async {
    // TODO: implement setAPNSListener
    throw UnimplementedError();
  }

  /// 实验性接口
  Future<ImValueCallback<dynamic>> callExperimentalAPI({
    required String api,
    required Object param,
  }) async {
    // TODO: implement callExperimentalAPI
    throw UnimplementedError();
  }

  /// 发送 C2C 文本消息（已弃用）
  Future<ImValueCallback<ImMessage>> sendC2CTextMessage({
    required String text,
    required String userID,
  }) async {
    // TODO: implement sendC2CTextMessage
    throw UnimplementedError();
  }

  /// 发送群组文本消息（已弃用）
  Future<ImValueCallback<ImMessage>> sendGroupTextMessage({
    required String text,
    required String groupID,
    dynamic priority,
  }) async {
    // TODO: implement sendGroupTextMessage
    throw UnimplementedError();
  }

  /// 获取信令管理器
  IMSignalingManager getSignalingManager() {
    // TODO: implement getSignalingManager
    throw UnimplementedError();
  }

  /// 检查能力位
  Future<ImValueCallback<int>> checkAbility() async {
    // TODO: implement checkAbility
    throw UnimplementedError();
  }

  /// 移除简单消息监听器
  Future<void> removeSimpleMsgListener({dynamic listener}) async {
    // TODO: implement removeSimpleMsgListener
    throw UnimplementedError();
  }

  /// 添加简单消息监听器
  Future<void> addSimpleMsgListener({dynamic listener}) async {
    // TODO: implement addSimpleMsgListener
    throw UnimplementedError();
  }
}
