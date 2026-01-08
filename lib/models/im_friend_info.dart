import 'im_user_full_info.dart';

class ImFriendInfo {
  /// 用户 ID
  late String userID;

  /// 好友备注
  late String? friendRemark;

  /// 好友分组列表
  List<String>? friendGroups = List.empty(growable: true);

  /// 好友自定义信息
  Map<String, String>? friendCustomInfo;

  /// 用户资料
  ImUserFullInfo? userProfile;

  ImFriendInfo({
    required this.userID,
    this.friendRemark,
    this.friendGroups,
    this.friendCustomInfo,
    this.userProfile,
  });

  ImFriendInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    friendRemark = json['friendRemark'];
    friendGroups = json['friendGroups'].cast<String>();
    friendCustomInfo = json['friendCustomInfo'] == null
        ? <String, String>{}
        : Map<String, String>.from(json['friendCustomInfo']);
    userProfile = json['userProfile'] != null
        ? ImUserFullInfo.fromJson(json['userProfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['friendRemark'] = friendRemark;
    data['friendGroups'] = friendGroups;
    data['friendCustomInfo'] = friendCustomInfo;
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
