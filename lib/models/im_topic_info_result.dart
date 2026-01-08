import 'im_topic_info.dart';

class ImTopicInfoResult {
  /// 错误码
  int? errorCode;

  /// 错误信息
  String? errorMessage;

  /// 话题信息
  ImTopicInfo? topicInfo;

  ImTopicInfoResult({this.errorCode, this.errorMessage, this.topicInfo});

  ImTopicInfoResult.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    if (json['topicInfo'] != null) {
      topicInfo = ImTopicInfo.fromJson(json['topicInfo']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["errorCode"] = errorCode;
    data["errorMessage"] = errorMessage;
    data["topicInfo"] = topicInfo?.toJson();
    return data;
  }
}
