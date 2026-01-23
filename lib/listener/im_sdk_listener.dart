import '../im_sdk_plugin.dart';
import '../models/im_user_status.dart';
import 'callbacks.dart';

/// IM SDK 监听器，用于监听 SDK 的连接状态、用户状态等
class ImSDKListener {
  /// 连接中回调
  VoidCallback onConnecting = () {};

  /// 连接成功回调
  VoidCallback onConnectSuccess = () {};

  /// 连接失败回调
  ErrorCallback onConnectFailed = (int code, String error) {};

  /// 被踢下线回调
  VoidCallback onKickedOffline = () {};

  /// 用户签名过期回调
  VoidCallback onUserSigExpired = () {};

  /// 当前用户信息更新回调
  ImUserFullInfoCallback onSelfInfoUpdated = (ImUserFullInfo info) {};

  /// 用户状态变更回调
  OnUserStatusChanged onUserStatusChanged = (List<ImUserStatus> userStatusList) {};

  /// 日志回调
  OnLog onLog = (int logLevel, String logContent) {};

  ImSDKListener({
    ErrorCallback? onConnectFailed,
    VoidCallback? onConnectSuccess,
    VoidCallback? onConnecting,
    VoidCallback? onKickedOffline,
    ImUserFullInfoCallback? onSelfInfoUpdated,
    VoidCallback? onUserSigExpired,
    OnUserStatusChanged? onUserStatusChanged,
    OnLog? onLog,
  }) {
    if (onConnectFailed != null) {
      this.onConnectFailed = onConnectFailed;
    }
    if (onConnectSuccess != null) {
      this.onConnectSuccess = onConnectSuccess;
    }
    if (onConnecting != null) {
      this.onConnecting = onConnecting;
    }
    if (onKickedOffline != null) {
      this.onKickedOffline = onKickedOffline;
    }
    if (onSelfInfoUpdated != null) {
      this.onSelfInfoUpdated = onSelfInfoUpdated;
    }
    if (onUserSigExpired != null) {
      this.onUserSigExpired = onUserSigExpired;
    }
    if (onUserStatusChanged != null) {
      this.onUserStatusChanged = onUserStatusChanged;
    }
    if (onLog != null) {
      this.onLog = onLog;
    }
  }
}
