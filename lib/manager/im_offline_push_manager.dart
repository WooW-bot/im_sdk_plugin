import '../models/im_callback.dart';

/// 离线推送管理器
abstract class IMOfflinePushManager {
  /// 应用切后台调用
  Future<ImCallback> doBackground({required int unreadCount});

  /// 应用切前台调用
  Future<ImCallback> doForeground();

  /// 设置离线推送配置
  Future<ImCallback> setOfflinePushConfig({
    required double businessID,
    required String token,
    bool isTPNSToken = false,
  });
}
