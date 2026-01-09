import 'im_elem.dart';
import 'im_image.dart';

/// 图片消息元素
class ImImageElem extends IMElem {
  /// 图片路径
  late String? path;

  /// 图片列表
  List<ImImage?>? imageList = List.empty(growable: true);

  ImImageElem({this.path, this.imageList});

  ImImageElem.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    if (json['imageList'] != null) {
      imageList = List.empty(growable: true);
      json['imageList'].forEach((v) {
        imageList!.add(ImImage.fromJson(v));
      });
    }
    if (json['nextElem'] != null) {
      nextElem = Map<String, dynamic>.from(json['nextElem']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    if (imageList != null) {
      data['imageList'] = imageList!.map((v) => v!.toJson()).toList();
    }
    if (nextElem != null) {
      data['nextElem'] = nextElem;
    }
    return data;
  }
}

// {
//   "path":"",
//   "imageList":[{}]
// }
