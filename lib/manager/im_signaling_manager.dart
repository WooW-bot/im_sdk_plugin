import 'package:im_sdk_plugin/mixins/mixin.dart';

import '../im_sdk_plugin.dart';
import '../listener/im_signaling_listener.dart';
import '../models/im_signaling_info.dart';

/// 信令管理器
class IMSignalingManager with BaseMixin {
  ImSignalingListener? _signalingListener;

  /// 设置信令监听器
  Future<void> setSignalingListener(ImSignalingListener? listener) async {
    Logger.debug("[IMSignalingManager] 设置信令监听器: ${listener != null ? '已设置' : '已清除'}");
    _signalingListener = listener;
  }

  /// 邀请个人
  Future<ImValueCallback<String>> invite({
    required String invitee,
    required String data,
    int timeout = 30,
    bool onlineUserOnly = false,
    OfflinePushInfo? offlinePushInfo,
  }) async {
    // TODO: implement invite
    throw UnimplementedError();
  }

  /// 邀请群组
  Future<ImValueCallback<String>> inviteInGroup({
    required String groupID,
    required List<String> inviteeList,
    required String data,
    int timeout = 30,
    bool onlineUserOnly = false,
  }) async {
    // TODO: implement inviteInGroup
    throw UnimplementedError();
  }

  /// 取消邀请
  Future<ImCallback> cancel({required String inviteID, String? data}) async {
    // TODO: implement cancel
    throw UnimplementedError();
  }

  /// 接受邀请
  Future<ImCallback> accept({required String inviteID, String? data}) async {
    // TODO: implement accept
    throw UnimplementedError();
  }

  /// 拒绝邀请
  Future<ImCallback> reject({required String inviteID, String? data}) async {
    // TODO: implement reject
    throw UnimplementedError();
  }

  /// 添加邀请信令
  Future<ImValueCallback<ImSignalingInfo>> addInvitedSignaling({
    required ImSignalingInfo info,
  }) async {
    // TODO: implement addInvitedSignaling
    throw UnimplementedError();
  }

  /// 获取信令信息
  Future<ImValueCallback<ImSignalingInfo>> getSignalingInfo({
    required String msgID,
  }) async {
    // TODO: implement getSignalingInfo
    throw UnimplementedError();
  }

  void handleSignalingCallback(MethodCall call) {
    Logger.debug("[IMSignalingManager] 收到信令回调");
    if (_signalingListener == null) {
      Logger.warn("[IMSignalingManager] 信令监听器未设置");
      return;
    }
    final listener = _signalingListener!;

    Map<String, dynamic> callData = formatJson(call.arguments);
    String type = callData['type'];
    Logger.debug("[IMSignalingManager] 处理信令事件: $type");

    Map<String, dynamic> params = callData['data'];
    String inviteID = params['inviteID'] ?? '';
    String inviter = params['inviter'] ?? '';
    String groupID = params['groupID'] ?? '';
    List<String>? inviteeList = params['inviteeList'] == null
        ? null
        : List.from(params['inviteeList']);
    String data = params['data'] ?? '';
    String invitee = params['invitee'] ?? '';

    safeExecute(() {
      switch (type) {
        case 'onReceiveNewInvitation':
          listener.onReceiveNewInvitation(
            inviteID,
            inviter,
            groupID,
            inviteeList!,
            data,
          );
          break;
        case 'onInviteeAccepted':
          listener.onInviteeAccepted(inviteID, invitee, data);
          break;
        case 'onInviteeRejected':
          listener.onInviteeRejected(inviteID, invitee, data);
          break;
        case 'onInvitationCancelled':
          listener.onInvitationCancelled(inviteID, inviter, data);
          break;
        case 'onInvitationTimeout':
          listener.onInvitationTimeout(inviteID, inviteeList!);
          break;
      }
    });
  }
}
