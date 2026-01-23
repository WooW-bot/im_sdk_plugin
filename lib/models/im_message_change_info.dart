import '../im_sdk_plugin.dart';

class ImMessageChangeInfo {
  /// 错误码
  int? code;

  /// 错误描述
  String? desc;

  /// 变更的消息
  ImMessage? message;

  ImMessageChangeInfo({this.code, this.desc, this.message});

  ImMessageChangeInfo.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    desc = json["desc"];
    if (json["message"] != null) {
      message = ImMessage.fromJson(json["message"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code;
    data["desc"] = desc;
    if (message != null) {
      data["message"] = message!.toJson();
    }
    return data;
  }
}
