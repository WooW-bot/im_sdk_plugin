class ImFriendGroup {
  /// 分组名称
  late String? name;

  /// 好友数量
  late int? friendCount;

  /// 好友 ID 列表
  late List<String>? friendIDList;

  ImFriendGroup({this.name, this.friendCount, this.friendIDList});

  ImFriendGroup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    friendCount = json['friendCount'];
    friendIDList = json['friendIDList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['friendCount'] = friendCount;
    data['friendIDList'] = friendIDList;
    return data;
  }
}

// {
//   "name":"",
//   "friendCount":0,
//   "friendIDList":[""]
// }
