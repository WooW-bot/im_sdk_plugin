import 'im_message.dart';

class ImMsgCreateInfoResult {
  /// 消息 ID
  late String? id;

  /// 消息信息
  late ImMessage? messageInfo;

  ImMsgCreateInfoResult({this.id, this.messageInfo});

  ImMsgCreateInfoResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageInfo = ImMessage.fromJson(json['messageInfo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (messageInfo != null) {
      data['memberInfoList'] = messageInfo!.toJson();
    }
    return data;
  }
}

// {
//   "nextSeq":0,
//   "memberInfoList":[{}]
// }
