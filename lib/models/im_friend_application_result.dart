import 'im_friend_application.dart';

class ImFriendApplicationResult {
  /// 未读申请数
  late int? unreadCount;

  /// 好友申请列表
  late List<ImFriendApplication?>? friendApplicationList = List.empty(
    growable: true,
  );

  ImFriendApplicationResult({this.unreadCount, this.friendApplicationList});

  ImFriendApplicationResult.fromJson(Map<String, dynamic> json) {
    unreadCount = json['unreadCount'];
    if (json['friendApplicationList'] != null) {
      json['friendApplicationList'].forEach((v) {
        friendApplicationList!.add(ImFriendApplication.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unreadCount'] = unreadCount;
    data['friendApplicationList'] = friendApplicationList!
        .map((v) => v!.toJson())
        .toList();
    return data;
  }
}

// {
//   "unreadCount":0,
//   "friendApplicationList":{},
// }
