class ImReceiveMessageOptInfo {
  /// C2C 消息接收选项
  late int? c2CReceiveMessageOpt;

  /// 用户 ID
  late String userID;

  ImReceiveMessageOptInfo({this.c2CReceiveMessageOpt, required this.userID});

  ImReceiveMessageOptInfo.fromJson(Map<String, dynamic> jsonStr) {
    c2CReceiveMessageOpt = jsonStr['c2CReceiveMessageOpt'];
    userID = jsonStr['userID'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['c2CReceiveMessageOpt'] = c2CReceiveMessageOpt;
    data['userID'] = userID;
    return data;
  }
}
