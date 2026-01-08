class ImGroupChangeInfo {
  /// 变更类型
  int? type;

  /// 变更值
  String? value;

  /// 变更键 (仅用于自定义字段)
  String? key;

  /// 布尔值
  bool? boolValue;

  ImGroupChangeInfo({required this.type, this.value, this.key, this.boolValue});

  ImGroupChangeInfo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    key = json['key'];
    boolValue = json['boolValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['key'] = key;
    data['boolValue'] = boolValue;
    return data;
  }
}

// {
//   "type":0,
//   "value":"",
//   "key":""
// }
