/// 回调默认返回值
class ImCallback {
  /// 错误码
  late int code;

  /// 错误描述
  late String msg;

  ImCallback({required this.code, required this.msg});

  bool get isSuccess => code == 200;

  static ImCallback success({String msg = "success"}) {
    return ImCallback(code: 200, msg: msg);
  }

  static ImCallback error({int code = -1, String msg = "Unknown Error"}) {
    return ImCallback(code: code, msg: msg);
  }

  ImCallback.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? -1;
    msg = json['msg'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    return data;
  }
}
