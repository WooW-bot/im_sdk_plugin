import 'im_elem.dart';

class ImFaceElem extends IMElem {
  /// 表情索引
  late int? index;

  /// 表情数据
  late String? data;

  ImFaceElem({this.index, this.data});

  ImFaceElem.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    data = json['data'];
    if (json['nextElem'] != null) {
      nextElem = Map<String, dynamic>.from(json['nextElem']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['index'] = index;
    data['data'] = this.data;
    if (nextElem != null) {
      data['nextElem'] = nextElem;
    }
    return data;
  }
}

// {
//   "index":1,
//   "data":""
// }
