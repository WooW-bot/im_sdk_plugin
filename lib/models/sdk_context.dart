import '../enums/log_level_enum.dart';

/// IM SDK 共享上下文，保存全局配置和状态。
class SDKContext {
  /// 腾讯云分配的 AppID。
  int? appID;

  /// API 主机地址。
  String apiHost;

  /// 当前登录的用户 ID。
  String? currentUserID;

  /// 当前用户的签名。
  String? userSig;

  /// 日志等级
  LogLevelEnum logLevel;

  /// 是否在控制台打印 IM 日志。
  bool showImLog;

  /// 存储本地数据（DB、日志等）的根目录。
  String? dataDir;

  /// 应用特定的监听器 UUID。
  String? listenerUuid;

  /// UI 平台标识符。
  int uiPlatform;

  SDKContext({
    this.appID,
    this.apiHost = "http://172.16.100.112:8000",
    this.currentUserID,
    this.userSig,
    this.logLevel = LogLevelEnum.IM_LOG_NONE,
    this.showImLog = false,
    this.dataDir,
    this.listenerUuid,
    this.uiPlatform = 0,
  });
}
