import 'im_message.dart';

/// V2TimConversationResult
///
/// {@category Models}
///
class ImMessageListResult {
  /// 是否拉取完成
  bool isFinished = false;

  /// 消息列表
  List<ImMessage> messageList = List.empty(growable: true);

  ImMessageListResult({required this.isFinished, required this.messageList});

  ImMessageListResult.fromJson(Map<String, dynamic> json) {
    isFinished = json['isFinished'] ?? false;
    if (json['messageList'] != null) {
      messageList = List.empty(growable: true);
      for (var v in List.from(json['messageList'])) {
        messageList.add(ImMessage.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFinished'] = isFinished;
    if (messageList.isNotEmpty) {
      data['messageList'] = messageList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
