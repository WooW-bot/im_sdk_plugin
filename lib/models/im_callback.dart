class ImCallback {
  /// 错误码
  late int code;

  /// 错误描述
  late String desc;

  ImCallback({required this.code, required this.desc});

  ImCallback.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['desc'] = desc;
    return data;
  }
}
