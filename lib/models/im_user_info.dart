class ImUserInfo {
  /// 用户 ID
  late String userID;

  /// 昵称
  late String? nickName;

  /// 头像 URL
  late String? faceUrl;

  ImUserInfo({required this.userID, this.nickName, this.faceUrl});

  ImUserInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    nickName = json['nickName'];
    faceUrl = json['faceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['nickName'] = nickName;
    data['faceUrl'] = faceUrl;
    return data;
  }
}

// {
//   "userID":"",
//   "nickName":"",
//   "faceUrl":""
// }
