class ImConversationSetEntity {
  String? conversationId;
  int? conversationType;
  String? fromId;
  String? toId;
  int? isMute;
  int? isTop;
  int? sequence;
  int? readSequence;
  int? appId;

  ImConversationSetEntity({
    this.conversationId,
    this.conversationType,
    this.fromId,
    this.toId,
    this.isMute,
    this.isTop,
    this.sequence,
    this.readSequence,
    this.appId,
  });

  ImConversationSetEntity.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversationId'];
    conversationType = json['conversationType'];
    fromId = json['fromId'];
    toId = json['toId'];
    isMute = json['isMute'];
    isTop = json['isTop'];
    sequence = json['sequence'];
    readSequence = json['readSequence'];
    appId = json['appId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversationId'] = conversationId;
    data['conversationType'] = conversationType;
    data['fromId'] = fromId;
    data['toId'] = toId;
    data['isMute'] = isMute;
    data['isTop'] = isTop;
    data['sequence'] = sequence;
    data['readSequence'] = readSequence;
    data['appId'] = appId;
    return data;
  }
}
