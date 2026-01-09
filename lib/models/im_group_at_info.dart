/// 群 @ 信息
class ImGroupAtInfo {
  /// 消息序列号
  late String seq;

  /// @ 类型
  late int atType;

  ImGroupAtInfo({required this.seq, required this.atType});

  ImGroupAtInfo.fromJson(Map<String, dynamic> json) {
    seq = json['seq'];
    atType = json['atType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seq'] = seq;
    data['atType'] = atType;
    return data;
  }
}

// {
//   "seq":0,
//   "atType":0
// }
