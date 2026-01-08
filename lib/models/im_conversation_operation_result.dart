class ImConversationOperationResult {
  /// 会话 ID
  String? conversationID;

  /// 结果码
  int? resultCode;

  /// 结果信息
  String? resultInfo;

  ImConversationOperationResult({
    this.conversationID,
    this.resultCode,
    this.resultInfo,
  });

  ImConversationOperationResult.fromJson(Map<String, dynamic> json) {
    conversationID = json['conversationID'];
    resultCode = json['resultCode'];
    resultInfo = json['resultInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversationID'] = conversationID;
    data['resultCode'] = resultCode;
    data['resultInfo'] = resultInfo;

    return data;
  }
}
