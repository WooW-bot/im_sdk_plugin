/// 话题操作结果
class ImTopicOperationResult {
  /// 错误码
  int? errorCode;

  /// 错误信息
  String? errorMessage;

  /// 话题 ID
  String? topicID;

  ImTopicOperationResult({this.errorCode, this.errorMessage, this.topicID});

  ImTopicOperationResult.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    topicID = json['topicID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorMessage'] = errorMessage;
    data['topicID'] = topicID;
    return data;
  }
}
