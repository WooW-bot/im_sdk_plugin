class ImGroupMemberChangeInfo {
  /// 用户 ID
  String? userID;

  /// 禁言时间
  int? muteTime;

  ImGroupMemberChangeInfo({this.userID, this.muteTime});

  ImGroupMemberChangeInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    muteTime = json['muteTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['muteTime'] = muteTime;
    return data;
  }
}

// {
//   "userID":"",
//   "muteTime":0
// }
