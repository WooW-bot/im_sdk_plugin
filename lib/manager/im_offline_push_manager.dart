import '../im_sdk_plugin.dart';

/// 离线推送管理器
class IMOfflinePushManager {
  /// 应用切后台调用
  Future<ImCallback> doBackground({required int unreadCount}) async {
    // TODO: implement doBackground
    throw UnimplementedError();
  }

  /// 应用切前台调用
  Future<ImCallback> doForeground() async {
    // TODO: implement doForeground
    throw UnimplementedError();
  }

  /// 设置离线推送配置
  Future<ImCallback> setOfflinePushConfig({
    required double businessID,
    required String token,
    bool isTPNSToken = false,
  }) async {
    // TODO: implement setOfflinePushConfig
    throw UnimplementedError();
  }
}
