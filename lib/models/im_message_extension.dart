/// 消息扩展
class ImMessageExtension {
  /// 扩展键
  String extensionKey = "";

  /// 扩展值
  String extensionValue = "";

  ImMessageExtension({required this.extensionKey, required this.extensionValue});

  ImMessageExtension.fromJson(Map<String, dynamic> json) {
    extensionKey = json["extensionKey"] ?? "";
    extensionValue = json["extensionValue"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["extensionKey"] = extensionKey;
    data["extensionValue"] = extensionValue;
    return data;
  }
}
