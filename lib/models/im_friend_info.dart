import 'im_user_full_info.dart';

/// 好友信息
class ImFriendInfo {
  /// 用户 ID (好友ID)
  late String toId;

  /// 好友备注
  late String? remark;

  /// 添加来源
  String? addSource;

  /// 添加时间
  int? createTime;

  /// 好友状态 (1-正常, 2-已删除)
  int? status;

  /// 黑名单状态 (0-正常, 1-已拉黑)
  int? black;

  /// 好友顺序号
  int? friendSequence;

  /// 好友分组列表
  List<String>? friendGroups = List.empty(growable: true);

  /// 好友自定义信息
  Map<String, String>? friendCustomInfo;

  /// 用户资料
  ImUserFullInfo? userProfile;

  ImFriendInfo({
    required this.toId,
    this.remark,
    this.friendGroups,
    this.friendCustomInfo,
    this.userProfile,
    this.addSource,
    this.createTime,
    this.status,
    this.black,
    this.friendSequence,
  });

  ImFriendInfo.fromJson(Map<String, dynamic> json) {
    toId = json['toId'] ?? json['userID'] ?? "";
    remark = json['remark'] ?? json['friendRemark'];
    if (json['friendGroups'] != null) {
      friendGroups = List<String>.from(json['friendGroups']);
    }
    if (json['extra'] != null) {
      // Backend 'extra' might be a JSON string or a Map depending on serialization
      if (json['extra'] is String && (json['extra'] as String).isNotEmpty) {
        // try parse if string
        // For now, assuming it returns a Map or acceptable format.
        // If it returns a JSON string, we might need jsonDecode.
        // However, standard flutter logic usually gets Map from platform channel.
        // Let's assume it might be mapped to friendCustomInfo
      } else if (json['extra'] is Map) {
        friendCustomInfo = Map<String, String>.from(json['extra']);
      }
    }
    // Fallback for old custom info field
    if (json['friendCustomInfo'] != null && friendCustomInfo == null) {
      friendCustomInfo = Map<String, String>.from(json['friendCustomInfo']);
    }

    addSource = json['addSource'];
    createTime = json['createTime'];
    status = json['status'];
    black = json['black'];
    friendSequence = json['friendSequence'];

    userProfile = json['userProfile'] != null
        ? ImUserFullInfo.fromJson(json['userProfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['toId'] = toId;
    data['remark'] = remark;
    data['friendGroups'] = friendGroups;
    data['friendCustomInfo'] = friendCustomInfo;
    data['addSource'] = addSource;
    data['createTime'] = createTime;
    data['status'] = status;
    data['black'] = black;
    data['friendSequence'] = friendSequence;
    if (userProfile != null) {
      data['userProfile'] = userProfile!.toJson();
    }
    return data;
  }
}

// {
//   "userID":"",
//   "friendRemark":"",
//   "friendGroups":[""],
//   "friendCustomInfo":{},
//   "userProfile":{}
// }
