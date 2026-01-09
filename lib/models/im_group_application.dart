/// 群申请信息
class ImGroupApplication {
  /// 群组 ID
  late String groupID;

  /// 请求者 ID
  late String? fromUser;

  /// 请求者昵称
  late String? fromUserNickName;

  /// 请求者头像
  late String? fromUserFaceUrl;

  /// 接收者 ID
  late String? toUser;

  /// 添加时间
  late int? addTime;

  /// 请求信息
  late String? requestMsg;

  /// 处理信息
  late String? handledMsg;

  /// 申请类型
  late int type;

  /// 处理状态
  late int handleStatus;

  /// 处理结果
  late int handleResult;

  ImGroupApplication({
    required this.groupID,
    this.fromUser,
    this.fromUserNickName,
    this.fromUserFaceUrl,
    this.toUser,
    this.addTime,
    this.requestMsg,
    this.handledMsg,
    required this.type,
    required this.handleStatus,
    required this.handleResult,
  });

  ImGroupApplication.fromJson(Map<String, dynamic> json) {
    groupID = json['groupID'];
    fromUser = json['fromUser'];
    fromUserNickName = json['fromUserNickName'];
    fromUserFaceUrl = json['fromUserFaceUrl'];
    toUser = json['toUser'];
    addTime = json['addTime'];
    requestMsg = json['requestMsg'];
    handledMsg = json['handledMsg'];
    type = json['type'];
    handleStatus = json['handleStatus'];
    handleResult = json['handleResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupID'] = groupID;
    data['fromUser'] = fromUser;
    data['fromUserNickName'] = fromUserNickName;
    data['fromUserFaceUrl'] = fromUserFaceUrl;
    data['toUser'] = toUser;
    data['addTime'] = addTime;
    data['requestMsg'] = requestMsg;
    data['handledMsg'] = handledMsg;
    data['type'] = type;
    data['handleStatus'] = handleStatus;
    data['handleResult'] = handleResult;
    return data;
  }
}

// {
//   "groupID":"",
//   "fromUser":"",
//    "fromUserNickName":"",
//    "fromUserFaceUrl":"",
//    "toUser":"",
//    "addTime":0,
//    "requestMsg":"",
//    "handledMsg":"",
//    "type":0,
//    "handleStatus":0,
//    "handleResult":0
// }
