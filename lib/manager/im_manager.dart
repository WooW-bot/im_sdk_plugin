import 'package:flutter/foundation.dart';
import 'package:im_sdk_core/im_sdk_core.dart';
import 'package:im_sdk_core/method_call_handler.dart';
import 'package:im_sdk_plugin/mixins/mixin.dart';
import '../im_sdk_plugin.dart';
import '../listener/im_sdk_listener.dart';
import '../models/im_user_status.dart';
import 'im_conversation_manager.dart';
import 'im_offline_push_manager.dart';
import 'im_signaling_manager.dart';
import 'im_friendship_manager.dart';
import 'im_group_manager.dart';
import 'im_message_manager.dart';

/// IM SDK 主核心管理类
class IMManager with BaseMixin {
  late IMConversationManager conversationManager;
  late IMMessageManager messageManager;
  late IMFriendshipManager friendshipManager;
  late IMGroupManager groupManager;
  late IMOfflinePushManager offlinePushManager;
  late IMSignalingManager signalingManager;
  late SDKContext _sdkContext;
  late ImSdkCore _imSdkCore;

  /// InitSDK 监听器
  ImSDKListener? _initSDKListener;

  /// 初始化 SDK
  ///
  /// [appID] 应用 ID
  /// [logLevel] 日志等级
  /// [listener] SDK 监听器
  /// [showImLog] 是否显示 IM 日志
  Future<ImValueCallback<bool>> initSDK({
    required String appID,
    required LogLevel logLevel,
    required ImSDKListener listener,
    bool? showImLog = false,
    String apiHost = "http://192.168.1.30:8000",
  }) async {
    Logger.setLogLevel(logLevel);
    Logger.info(
      "[IMManager] 初始化 SDK - appID: $appID, logLevel: $logLevel, apiHost: $apiHost",
    );
    _sdkContext = SDKContext(
      appID: appID,
      apiHost: apiHost,
      showImLog: showImLog ?? false,
    );
    _imSdkCore = ImSdkCore(_sdkContext);

    conversationManager = IMConversationManager(_imSdkCore);
    messageManager = IMMessageManager(_imSdkCore);
    friendshipManager = IMFriendshipManager(_imSdkCore);
    groupManager = IMGroupManager(_imSdkCore);
    offlinePushManager = IMOfflinePushManager();
    offlinePushManager = IMOfflinePushManager();
    signalingManager = IMSignalingManager();

    setInitSDKListener(listener);
    setupNativeCallback(_imSdkCore);

    Logger.info("[IMManager] SDK 初始化成功");
    return ImValueCallback.success(data: true);
  }

  /// 设置InitSDK监听器
  Future<void> setInitSDKListener(ImSDKListener? listener) async {
    Logger.debug(
      "[IMManager] 设置 InitSDK 监听器: ${listener != null ? '已设置' : '已清除'}",
    );
    _initSDKListener = listener;
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
    Logger.info("[IMManager] 开始登录 - userID: $userID");
    final result = await _imSdkCore.login(userID: userID, userSig: userSig);
    if (result.isSuccess) {
      Logger.info("[IMManager] 登录成功 - userID: $userID");
    } else {
      Logger.error(
        "[IMManager] 登录失败 - userID: $userID, code: ${result.code}, msg: ${result.msg}",
      );
    }
    return result;
  }

  /// 登出
  Future<ImCallback> logout() async {
    Logger.info("[IMManager] 开始登出");
    final result = _imSdkCore.logout();
    Logger.info("[IMManager] 登出成功");
    return result;
  }

  /// 获取当前登录用户
  Future<ImValueCallback<String>> getLoginUser() async {
    Logger.debug("[IMManager] 获取当前登录用户");
    final result = await _imSdkCore.getLoginUser();
    if (result.isSuccess) {
      Logger.debug("[IMManager] 当前登录用户: ${result.data}");
    } else {
      Logger.warn("[IMManager] 用户未登录");
    }
    return result;
  }

  /// 获取登录状态
  Future<ImValueCallback<int>> getLoginStatus() async {
    Logger.debug("[IMManager] 获取登录状态");
    final result = _imSdkCore.getLoginStatus();
    Logger.debug("[IMManager] 登录状态: ${result.data}");
    return result;
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
    // TODO: implement addFriendListener
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
    return signalingManager;
  }

  /// 检查能力位
  Future<ImValueCallback<int>> checkAbility() async {
    // TODO: implement checkAbility
    throw UnimplementedError();
  }

  /// 设置原生回调处理器
  ///
  /// 注册 MethodCallHandler 以处理来自 Core 的回调事件
  /// [handler] 方法调用处理器
  void setupNativeCallback(MethodCallHandler handler) {
    handler.setMethodCallHandler((call) {
      try {
        if (call.method == ListenerType.initSDKListener) {
          handleInitSDKCallback(call);
        } else if (call.method == ListenerType.groupListener) {
          getGroupManager().handleGroupCallback(call);
        } else if (call.method == ListenerType.advancedMsgListener) {
          getMessageManager().handleAdvancedMsgCallback(call);
        } else if (call.method == ListenerType.conversationListener) {
          getConversationManager().handleConversationCallback(call);
        } else if (call.method == ListenerType.friendListener) {
          getFriendshipManager().handleFriendCallback(call);
        } else if (call.method == ListenerType.signalingListener) {
          getSignalingManager().handleSignalingCallback(call);
        }
      } catch (err, stackTrace) {
        Logger.error(
          "回调处理失败: ${call.method}",
          error: err,
          stackTrace: stackTrace,
        );
      }
      return Future.value(null);
    });
  }

  /// 处理 InitSDK 回调
  @protected
  void handleInitSDKCallback(MethodCall call) {
    Logger.debug("[IMManager] 收到 InitSDK 回调");
    if (_initSDKListener == null) {
      Logger.warn("[IMManager] InitSDK 监听器未设置");
      return;
    }
    final listener = _initSDKListener!;

    final Map<String, dynamic> data = formatJson(call.arguments);
    final String type = data['type'];
    Logger.debug("[IMManager] 处理 InitSDK 事件: $type");

    final Map<String, dynamic> params = data['data'] ?? <String, dynamic>{};

    safeExecute(() {
      switch (type) {
        case 'onSelfInfoUpdated':
          final userInfo = ImUserFullInfo.fromJson(params);
          listener.onSelfInfoUpdated(userInfo);
          break;
        case 'onConnectFailed':
          listener.onConnectFailed(params['code'], params['desc']);
          break;
        case 'onConnecting':
          listener.onConnecting();
          break;
        case 'onConnectSuccess':
          listener.onConnectSuccess();
          break;
        case 'onKickedOffline':
          listener.onKickedOffline();
          break;
        case 'onUserSigExpired':
          listener.onUserSigExpired();
          break;
        case 'onUserStatusChanged':
          final List<dynamic> statusList = params['statusList'] ?? [];
          // TODO: 需要转换为 ImUserStatus 类型
          // 暂时使用 dynamic 类型，待 ImUserStatus 类型定义完成后修改
          listener.onUserStatusChanged(statusList as dynamic);
          break;
        case 'onLog':
          listener.onLog(params['level'], params['content']);
          break;
        default:
          Logger.warn('未知的 InitSDK 事件类型: $type');
      }
    });
  }
}
