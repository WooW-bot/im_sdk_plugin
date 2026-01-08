import 'im_conversation.dart';

class ImConversationResult {
  /// 下一次拉取的序列号
  late String? nextSeq;

  /// 是否拉取完成
  late bool? isFinished;

  /// 会话列表
  List<ImConversation?>? conversationList = List.empty(growable: true);

  ImConversationResult({this.nextSeq, this.isFinished, this.conversationList});

  ImConversationResult.fromJson(Map<String, dynamic> json) {
    nextSeq = json['nextSeq'];
    isFinished = json['isFinished'];
    if (json['conversationList'] != null) {
      conversationList = List.empty(growable: true);
      json['conversationList'].forEach((v) {
        conversationList!.add(ImConversation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextSeq'] = nextSeq;
    data['isFinished'] = isFinished;
    if (conversationList != null) {
      data['conversationList'] = conversationList!
          .map((v) => v!.toJson())
          .toList();
    }
    return data;
  }
}

// {
//   "nextSeq":0,
//   "isFinished":true,
//   "conversationList":[{}]
// }
