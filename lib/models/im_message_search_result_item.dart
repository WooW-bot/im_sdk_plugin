import '../im_sdk_plugin.dart';

/// 消息搜索结果项
class ImMessageSearchResultItem {
  /// 会话 ID
  String? conversationID;

  /// 消息数量
  int? messageCount;

  /// 消息列表
  List<ImMessage>? messageList;

  ImMessageSearchResultItem({this.conversationID, this.messageCount, this.messageList});

  ImMessageSearchResultItem.fromJson(Map<String, dynamic> json) {
    conversationID = json['conversationID'];
    messageCount = json['messageCount'];
    if (json['messageList'] != null) {
      messageList = List.empty(growable: true);
      json['messageList'].forEach((v) {
        messageList!.add(ImMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversationID'] = conversationID;
    data['messageCount'] = messageCount;
    if (messageList != null) {
      data['messageList'] = messageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// {
//   "userID":"",
//   "timestamp":0
// }
