class ImFriendApplication {
  /// 用户 ID
  late String userID;

  /// 昵称
  late String? nickname;

  /// 头像 URL
  late String? faceUrl;

  /// 添加时间
  late int? addTime;

  /// 添加来源
  late String? addSource;

  /// 附言
  late String? addWording;

  /// 申请类型
  late int type;

  ImFriendApplication({
    required this.userID,
    this.nickname,
    this.faceUrl,
    this.addTime,
    this.addSource,
    this.addWording,
    required this.type,
  });

  ImFriendApplication.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    nickname = json['nickname'];
    faceUrl = json['faceUrl'];
    addTime = json['addTime'];
    addSource = json['addSource'];
    addWording = json['addWording'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['nickname'] = nickname;
    data['faceUrl'] = faceUrl;
    data['addTime'] = addTime;
    data['addSource'] = addSource;
    data['addWording'] = addWording;
    data['type'] = type;
    return data;
  }
}

// {
//   "userID":"",
//   "nickname":"",
//   "faceUrl":"",
//   "addTime":0,
//   "addSource":"",
//   "addWording":"",
//   "type":1
// }
