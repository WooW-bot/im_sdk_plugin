class ImFriendCheckResult {
  /// 用户 ID
  late String userID;

  /// 结果码
  late int resultCode;

  /// 结果信息
  late String? resultInfo;

  /// 结果类型
  late int resultType;

  ImFriendCheckResult({
    required this.userID,
    required this.resultCode,
    this.resultInfo,
    required this.resultType,
  });

  ImFriendCheckResult.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    resultCode = json['resultCode'];
    resultInfo = json['resultInfo'];
    resultType = json['resultType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['resultCode'] = resultCode;
    data['resultInfo'] = resultInfo;
    data['resultType'] = resultType;
    return data;
  }
}

// {
//   "userID" : "",
//     "resultCode" : 0,
//     "resultInfo" : "",
//     "resultType" : 0,
// }
