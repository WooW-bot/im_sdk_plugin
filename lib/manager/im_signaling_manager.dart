import 'package:im_sdk_plugin/mixins/mixin.dart';

import '../im_sdk_plugin.dart';
import '../listener/im_signaling_listener.dart';

/// 信令管理器
class IMSignalingManager with BaseMixin {
  final ImSdkCore _imCore;

  ImSignalingListener? _signalingListener;

  IMSignalingManager(this._imCore);

  /// 设置信令监听器
  Future<void> setSignalingListener(ImSignalingListener? listener) async {
    Logger.debug(
      "[IMSignalingManager] 设置信令监听器: ${listener != null ? '已设置' : '已清除'}",
    );
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
    return _imCore.invite(
      invitee: invitee,
      data: data,
      timeout: timeout,
      onlineUserOnly: onlineUserOnly,
      offlinePushInfo: offlinePushInfo,
    );
  }

  /// 邀请群组
  Future<ImValueCallback<String>> inviteInGroup({
    required String groupID,
    required List<String> inviteeList,
    required String data,
    int timeout = 30,
    bool onlineUserOnly = false,
  }) async {
    return _imCore.inviteInGroup(
      groupID: groupID,
      inviteeList: inviteeList,
      data: data,
      timeout: timeout,
      onlineUserOnly: onlineUserOnly,
    );
  }

  /// 取消邀请
  Future<ImCallback> cancel({required String inviteID, String? data}) async {
    return _imCore.cancel(inviteID: inviteID, data: data);
  }

  /// 接受邀请
  Future<ImCallback> accept({required String inviteID, String? data}) async {
    return _imCore.accept(inviteID: inviteID, data: data);
  }

  /// 拒绝邀请
  Future<ImCallback> reject({required String inviteID, String? data}) async {
    return _imCore.reject(inviteID: inviteID, data: data);
  }

  /// 添加邀请信令
  Future<ImValueCallback<ImSignalingInfo>> addInvitedSignaling({
    required ImSignalingInfo info,
  }) async {
    return _imCore.addInvitedSignaling(info: info);
  }

  /// 获取信令信息
  Future<ImValueCallback<ImSignalingInfo>> getSignalingInfo({
    required String msgID,
  }) async {
    return _imCore.getSignalingInfo(msgID: msgID);
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
