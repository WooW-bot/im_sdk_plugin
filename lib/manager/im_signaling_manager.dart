import 'package:uuid/uuid.dart';

import '../listener/im_signaling_listener.dart';
import '../models/offline_push_info.dart';
import '../models/im_callback.dart';
import '../models/im_value_callback.dart';
import '../models/im_signaling_info.dart';

/// 信令管理器
class IMSignalingManager {
  Map<String, ImSignalingListener> signalingListenerList = {};

  /// 添加信令监听器
  Future<void> addSignalingListener({required ImSignalingListener listener}) async {
    final String listenerUuid = Uuid().v4();
    signalingListenerList[listenerUuid] = listener;
    /*    return ImFlutterPlatform.instance.addSignalingListener(
      listenerUuid: listenerUuid,
      listener: listener,
    );*/
  }

  /// 移除信令监听器
  Future<void> removeSignalingListener({ImSignalingListener? listener}) async {
    var listenerUuid = "";
    if (listener != null) {
      listenerUuid = signalingListenerList.keys.firstWhere(
        (k) => signalingListenerList[k] == listener,
        orElse: () => "",
      );
      signalingListenerList.remove(listenerUuid);
    } else {
      signalingListenerList.clear();
    }
    /*    return ImFlutterPlatform.instance
        .removeSignalingListener(listenerUuid: listenerUuid);*/
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
  Future<ImValueCallback<ImSignalingInfo>> getSignalingInfo({required String msgID}) async {
    // TODO: implement getSignalingInfo
    throw UnimplementedError();
  }
}
