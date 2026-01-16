import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:im_sdk_plugin/listener/im_simple_msg_listener.dart';
import 'package:im_sdk_plugin/models/login_model.dart';
import 'package:im_sdk_plugin/models/user_model.dart';
import 'package:uuid/uuid.dart';

import '../db/db_manager.dart';
import '../listener/im_group_listener.dart';
import '../listener/im_sdk_listener.dart';
import '../enums/log_level_enum.dart';
import '../enums/login_status_enum.dart';
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
import '../models/sdk_context.dart';
import '../models/im_message.dart';
import '../core/im_core.dart';

/// IM SDK 主核心管理类
class IMManager {
  late IMConversationManager conversationManager;
  late IMMessageManager messageManager;
  late IMFriendshipManager friendshipManager;
  late IMGroupManager groupManager;
  late IMOfflinePushManager offlinePushManager;
  late IMSignalingManager signalingManager;
  late Map<String, ImSimpleMsgListener> simpleMessageListenerList = {};
  late Map<String, ImSDKListener> initSDKListenerList = {};
  late Map<String, ImGroupListener> groupListenerList = {};

  final SDKContext _sdkContext = SDKContext();
  late ImCore _imCore;

  // 内部登录状态
  int _loginStatus = LoginStatusEnum.limit.index;

  IMManager() {
    _imCore = ImCore(_sdkContext);
    conversationManager = IMConversationManager();
    messageManager = IMMessageManager();
    friendshipManager = IMFriendshipManager(_sdkContext, _imCore);
    groupManager = IMGroupManager();
    offlinePushManager = IMOfflinePushManager();
    signalingManager = IMSignalingManager();
  }

  /// 初始化 SDK
  ///
  /// [appID] 应用 ID
  /// [loglevel] 日志等级
  /// [listener] SDK 监听器
  /// [showImLog] 是否显示 IM 日志
  Future<ImValueCallback<bool>> initSDK({
    required int appID,
    required LogLevelEnum logLevel,
    required ImSDKListener listener,
    bool? showImLog = false,
    String apiHost = "http://172.16.100.112:8000",
  }) async {
    final String uuid = Uuid().v4();

    // 更新 SDKContext
    _sdkContext.appID = appID;
    _sdkContext.apiHost = apiHost;
    _sdkContext.logLevel = logLevel;
    _sdkContext.listenerUuid = uuid;
    _sdkContext.showImLog = showImLog ?? false;
    _sdkContext.uiPlatform = _getPlatform();

    // 初始化时重置为登出状态
    _loginStatus = LoginStatusEnum.logout.index;

    initSDKListenerList[uuid] = listener;

    // 2. 初始化日志 (Stub)
    if (_sdkContext.showImLog) {
      print("IMSDK: [Init] Logger initialized. Level: ${_sdkContext.logLevel}");
    }

    // 3. 注册监听器
    initSDKListenerList[uuid] = listener;

    // 4. 初始化数据库 (模拟)
    if (_sdkContext.showImLog) {
      print("IMSDK: [Init] Preparing local database...");
    }
    await Future.delayed(const Duration(milliseconds: 50));
    if (_sdkContext.showImLog) {
      print("IMSDK: [Init] Database ready (Simulated SQLite).");
    }

    // 5. 初始化网络 (在登录中进行)
    // 根据服务器架构，实际连接发生在登录返回路由后。
    // initSDK 仅准备本地资源。

    return ImValueCallback.success(data: true);
  }

  int _getPlatform() {
    if (kIsWeb) return 0;
    if (Platform.isAndroid) return 1;
    if (Platform.isIOS) return 2;
    if (Platform.isMacOS) return 3;
    if (Platform.isWindows) return 4;
    if (Platform.isLinux) return 5;
    return 6;
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
  Future<ImValueCallback<dynamic>> login({
    required String userID,
    required String userSig,
  }) async {
    try {
      if (_loginStatus == LoginStatusEnum.logged.index) {
        return ImValueCallback.error(msg: "Already logged in");
      }

      _loginStatus = LoginStatusEnum.logging.index;

      // 1. HTTP 请求从后端获取路由信息
      final req = LoginReq(
        appId: _sdkContext.appID ?? 0,
        userId: userID,
        clientType: 1, // 1 for Desktop/App
      );

      final ImValueCallback<RouteInfo> response = await _imCore.post<RouteInfo>(
        "/v1/user/login",
        data: req.toJson(),
      );

      if (response.isSuccess && response.data != null) {
        final routeInfo = response.data!;

        // 2. 初始化数据库
        await DBManager().initDB(userID);

        // 3. 建立 TCP 连接
        await _connectSocket(routeInfo);

        _triggerNativeEvent(_sdkContext.listenerUuid!, 'onConnectSuccess');
        _sdkContext.currentUserID = userID;
        _sdkContext.userSig = userSig;
        _loginStatus = LoginStatusEnum.logged.index;
        return response;
      } else {
        _triggerNativeEvent(_sdkContext.listenerUuid!, 'onConnectFailed', {
          'code': response.code,
          'desc': response.msg,
        });
        return ImValueCallback.error(code: response.code, msg: response.msg);
      }
    } catch (e) {
      _loginStatus = LoginStatusEnum.logout.index;
      _triggerNativeEvent(_sdkContext.listenerUuid ?? "", 'onConnectFailed', {
        'code': -1,
        'desc': e.toString(),
      });
      return ImValueCallback.error(msg: "Login Failed: $e");
    }
  }

  Future<void> _connectSocket(RouteInfo routeInfo) async {
    _triggerNativeEvent(_sdkContext.listenerUuid!, 'onConnecting');
    try {
      if (routeInfo.ip.isNotEmpty && routeInfo.port > 0) {
        final socket = await Socket.connect(
          routeInfo.ip,
          routeInfo.port,
          timeout: Duration(seconds: 5),
        );
        if (_sdkContext.showImLog) {
          print("IMSDK: Connected to ${routeInfo.ip}:${routeInfo.port}");
        }
        socket.destroy();
      } else {
        print("IMSDK: Invalid RouteInfo: ${routeInfo.ip}:${routeInfo.port}");
      }
    } catch (e) {
      print("IMSDK: TCP Connection warning: $e");
    }
  }

  /// 登出
  Future<ImCallback> logout() async {
    _loginStatus = LoginStatusEnum.logout.index;
    _sdkContext.currentUserID = null;
    _sdkContext.userSig = null;
    return ImCallback.success(msg: "Logout Success");
  }

  /// 获取当前登录用户
  Future<ImValueCallback<String>> getLoginUser() async {
    if (_sdkContext.currentUserID == null) {
      return ImValueCallback.error(msg: "Not logged in", data: "");
    }
    return ImValueCallback.success(
      msg: "Success",
      data: _sdkContext.currentUserID!,
    );
  }

  /// 获取登录状态
  Future<ImValueCallback<int>> getLoginStatus() async {
    return ImValueCallback.success(msg: "Success", data: _loginStatus);
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
    return conversationManager;
  }

  /// 获取关系链管理器
  IMFriendshipManager getFriendshipManager() {
    return friendshipManager;
  }

  /// 获取群组管理器
  IMGroupManager getGroupManager() {
    return groupManager;
  }

  /// 获取消息管理器
  IMMessageManager getMessageManager() {
    return messageManager;
  }

  /// 获取离线推送管理器
  IMOfflinePushManager getOfflinePushManager() {
    return offlinePushManager;
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
    try {
      if (_sdkContext.appID == null) {
        return ImValueCallback.error(msg: "SDK not initialized", data: []);
      }

      final req = GetUserInfoReq(userIds: userIDList);

      return await _imCore.post<List<ImUserFullInfo>>(
        "/v1/user/data/getUserInfo",
        data: req.toJson(),
      );
    } catch (e) {
      return ImValueCallback.error(msg: "getUsersInfo Failed: $e", data: []);
    }
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

  /// 模拟原生事件回调的内部助手
  void _triggerNativeEvent(String listenerUuid, String type, [dynamic data]) {
    final listener = initSDKListenerList[listenerUuid];
    if (listener != null) {
      switch (type) {
        case 'onConnecting':
          listener.onConnecting();
          break;
        case 'onConnectSuccess':
          listener.onConnectSuccess();
          break;
        case 'onConnectFailed':
          listener.onConnectFailed(
            data?['code'] ?? -1,
            data?['desc'] ?? "Unknown Error",
          );
          break;
        case 'onKickedOffline':
          listener.onKickedOffline();
          break;
        case 'onUserSigExpired':
          listener.onUserSigExpired();
          break;
      }
    }
  }
}
