import 'im_elem.dart';

/// 合并消息元素
class ImMergerElem extends IMElem {
  /// 是否超过最大层数
  late bool? isLayersOverLimit;

  /// 标题
  late String? title;

  /// 摘要列表
  List<String>? abstractList = List.empty(growable: true);

  ImMergerElem({this.isLayersOverLimit, this.title, this.abstractList});

  ImMergerElem.fromJson(Map<String, dynamic> json) {
    isLayersOverLimit = json['isLayersOverLimit'];
    title = json['title'];
    abstractList = json['abstractList'].cast<String>();
    if (json['nextElem'] != null) {
      nextElem = Map<String, dynamic>.from(json['nextElem']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isLayersOverLimit'] = isLayersOverLimit;
    data['title'] = title;
    data['abstractList'] = abstractList;
    if (nextElem != null) {
      data['nextElem'] = nextElem;
    }
    return data;
  }
}

// {
//   "isLayersOverLimit":true,
//   "title":"",
//   "abstractList":[""],
// }
