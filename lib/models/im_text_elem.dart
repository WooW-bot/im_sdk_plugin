import 'dart:convert';
import 'im_elem.dart';

/// 文本消息元素
class ImTextElem extends IMElem {
  /// 文本内容
  late String? text;

  ImTextElem({this.text});

  ImTextElem.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    if (json['nextElem'] != null) {
      nextElem = Map<String, dynamic>.from(json['nextElem']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    if (nextElem != null) {
      data['nextElem'] = nextElem;
    }
    return data;
  }

  formatJson(jsonSrc) {
    return json.decode(json.encode(jsonSrc));
  }
}

// {
//   "text":""
// }
