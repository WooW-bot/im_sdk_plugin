import 'im_elem.dart';

/// 文件消息元素
class ImFileElem extends IMElem {
  /// 文件路径
  late String? path;

  /// 文件名
  late String? fileName;

  // ignore: non_constant_identifier_names
  /// 唯一 ID
  late String? UUID;

  /// 下载 URL
  late String? url;

  /// 文件大小
  late int? fileSize;

  /// 本地 URL
  String? localUrl;

  ImFileElem({
    this.path,
    this.fileName,
    // ignore: non_constant_identifier_names
    this.UUID,
    this.url,
    this.fileSize,
    this.localUrl,
  });

  ImFileElem.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    fileName = json['fileName'];
    UUID = json['UUID'];
    url = json['url'];
    localUrl = json['localUrl'];
    fileSize = json['fileSize'];
    if (json['nextElem'] != null) {
      nextElem = Map<String, dynamic>.from(json['nextElem']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['fileName'] = fileName;
    data['UUID'] = UUID;
    data['url'] = url;
    data['fileSize'] = fileSize;
    data['localUrl'] = localUrl;
    if (nextElem != null) {
      data['nextElem'] = nextElem;
    }
    return data;
  }
}

// {
//   "path":"",
//   "fileName":"",
//   "UUID":"",
//   "url":"",
//   "fileSize": 0
// }
