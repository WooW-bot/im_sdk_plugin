import '../enum/offlinePushInfo.dart';

/// 信令信息
class ImSignalingInfo {
  /// 邀请 ID
  late String inviteID;

  /// 邀请人 ID
  late String inviter;

  /// 被邀请人列表
  late List<dynamic> inviteeList;

  /// 群组 ID
  String? groupID;

  /// 自定义数据
  String? data;

  /// 超时时间
  int? timeout;

  /// 动作类型
  late int actionType;

  /// 业务 ID (iOS 不会返回)
  late int? businessID;

  /// 是否仅在线用户推送 (iOS 不会返回)
  late bool? isOnlineUserOnly;

  /// 离线推送信息 (iOS 不会返回)
  late OfflinePushInfo? offlinePushInfo;

  ImSignalingInfo({
    required this.inviteID,
    required this.inviter,
    required this.inviteeList,
    required this.actionType,
    required this.businessID,
    required this.isOnlineUserOnly,
    required this.offlinePushInfo,
    this.groupID,
    this.data,
    this.timeout,
  });

  ImSignalingInfo.fromJson(Map<String, dynamic> json) {
    inviteID = json['inviteID'];
    groupID = json['groupID'];
    inviter = json['inviter'];
    inviteeList = json['inviteeList'];
    data = json['data'];
    timeout = json['timeout'];
    actionType = json['actionType'];
    // 下方三个参数ios不会返回
    if (json['businessID'] != null) businessID = json['businessID'];
    if (json['isOnlineUserOnly'] != null) {
      isOnlineUserOnly = json['isOnlineUserOnly'];
    }
    if (json['offlinePushInfo'] != null) {
      offlinePushInfo = OfflinePushInfo.fromJson(json['offlinePushInfo']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inviteID'] = inviteID;
    data['groupID'] = groupID;
    data['inviter'] = inviter;
    data['inviteeList'] = inviteeList;
    data['data'] = this.data;
    data['timeout'] = timeout;
    data['actionType'] = actionType;
    // 下方三个参数ios不会返回
    if (data['businessID'] != null) data['businessID'] = businessID;
    if (data['businessID'] != null) {
      data['isOnlineUserOnly'] = isOnlineUserOnly;
    }
    if (data['offlinePushInfo'] != null) {
      data['offlinePushInfo'] = offlinePushInfo?.toJson();
    }
    return data;
  }
}
