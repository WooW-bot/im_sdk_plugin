import 'im_elem.dart';

/// 自定义消息元素
class ImCustomElem extends IMElem {
  /// 自定义数据
  late String? data;

  /// 描述
  late String? desc;

  /// 扩展信息
  late String? extension;

  ImCustomElem({this.data, this.desc, this.extension});

  ImCustomElem.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    desc = json['desc'];
    extension = json['extension'];
    if (json['nextElem'] != null) {
      nextElem = Map<String, dynamic>.from(json['nextElem']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['desc'] = desc;
    data['extension'] = extension;
    if (nextElem != null) {
      data['nextElem'] = nextElem;
    }
    return data;
  }
}
