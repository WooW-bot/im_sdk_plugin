import 'im_friend_info.dart';

/// 好友信息结果
class ImFriendInfoResult {
  /// 结果码
  late int resultCode;

  /// 结果信息
  late String? resultInfo;

  /// 关系类型
  late int? relation;

  /// 好友信息
  ImFriendInfo? friendInfo;

  ImFriendInfoResult({required this.resultCode, this.resultInfo, this.relation, this.friendInfo});

  ImFriendInfoResult.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultInfo = json['resultInfo'];
    relation = json['relation'];
    friendInfo = json['friendInfo'] != null ? ImFriendInfo.fromJson(json['friendInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resultCode'] = resultCode;
    data['resultInfo'] = resultInfo;
    data['relation'] = relation;
    if (friendInfo != null) {
      data['friendInfo'] = friendInfo!.toJson();
    }
    return data;
  }
}

// {
//   "resultCode":0,
//   "resultInfo":"",
//   "relation":0,
//   "friendInfo":"_$ImFriendInfo"
// }
