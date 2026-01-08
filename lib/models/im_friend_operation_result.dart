class ImFriendOperationResult {
  /// 用户 ID
  late String? userID;

  /// 结果码
  late int? resultCode;

  /// 结果信息
  late String? resultInfo;

  ImFriendOperationResult({
    required this.userID,
    this.resultCode,
    this.resultInfo,
  });

  ImFriendOperationResult.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    resultCode = json['resultCode'];
    resultInfo = json['resultInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['resultCode'] = resultCode;
    data['resultInfo'] = resultInfo;
    return data;
  }
}

// {
//   "userID":"",
//   "resultCode":0,
//   "resultInfo":""
// }
