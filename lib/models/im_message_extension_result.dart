import 'im_message_extension.dart';

class ImMessageExtensionResult {
  /// 结果码
  late int resultCode;

  /// 结果信息
  late String resultInfo;

  /// 扩展信息
  late ImMessageExtension? extension;

  ImMessageExtensionResult({
    required this.resultCode,
    required this.resultInfo,
    required this.extension,
  });

  ImMessageExtensionResult.fromJson(Map<String, dynamic> json) {
    resultCode = json["resultCode"] ?? -1;
    resultInfo = json["resultInfo"] ?? "";
    if (json["extension"] != null) {
      extension = ImMessageExtension.fromJson(json["extension"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["resultCode"] = resultCode;
    data["resultInfo"] = resultInfo;
    data["extension"] = extension?.toJson();
    return data;
  }
}
