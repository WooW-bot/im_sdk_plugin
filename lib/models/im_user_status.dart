class ImUserStatus {
  /// 用户 ID
  String? userID;

  /// 状态类型
  int? statusType;

  /// 自定义状态
  String? customStatus;

  ImUserStatus({this.userID, this.statusType, this.customStatus});

  ImUserStatus.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    statusType = json['statusType'];
    customStatus = json['customStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userID;
    data['statusType'] = statusType;
    data['customStatus'] = customStatus;
    return data;
  }
}

// {
//   "userId":"",
//   "role":""
// }
