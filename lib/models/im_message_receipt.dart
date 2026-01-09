/// 消息已读回执
class ImMessageReceipt {
  /// 用户 ID
  late String userID;

  /// 时间戳
  late int timestamp;

  /// 群组 ID
  late String? groupID;

  /// 消息 ID
  late String? msgID;

  /// 已读数
  late int? readCount;

  /// 未读数
  late int? unreadCount;

  ImMessageReceipt({
    required this.userID,
    required this.timestamp,
    this.groupID,
    this.msgID,
    this.readCount,
    this.unreadCount,
  });

  ImMessageReceipt.fromJson(Map<String, dynamic> json) {
    userID = json['userID'] ?? "";
    timestamp = json['timestamp'];
    msgID = json['msgID'] ?? "";
    readCount = json['readCount'];
    unreadCount = json['unreadCount'];
    groupID = json['groupID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['timestamp'] = timestamp;
    data['groupID'] = groupID ?? "";
    data['msgID'] = msgID;
    data['readCount'] = readCount;
    data['unreadCount'] = unreadCount;
    return data;
  }
}

// {
//   "userID":"",
//   "timestamp":0
// }
