import 'im_elem.dart';

class ImSoundElem extends IMElem {
  /// 语音路径
  late String? path;

  // ignore: non_constant_identifier_names
  /// 语音 UUID
  late String? UUID;

  /// 数据大小
  late int? dataSize;

  /// 时长
  late int? duration;

  /// 下载 URL
  late String? url;

  /// 本地 URL
  String? localUrl;

  ImSoundElem({
    this.path,
    // ignore: non_constant_identifier_names
    this.UUID,
    this.dataSize,
    this.duration,
    this.url,
    this.localUrl,
  });

  ImSoundElem.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    UUID = json['UUID'];
    dataSize = json['dataSize'];
    duration = json['duration'];
    localUrl = json['localUrl'];
    url = json['url'];
    if (json['nextElem'] != null) {
      nextElem = Map<String, dynamic>.from(json['nextElem']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['UUID'] = UUID;
    data['dataSize'] = dataSize;
    data['duration'] = duration;
    data['localUrl'] = localUrl;
    data['url'] = url;
    if (nextElem != null) {
      data['nextElem'] = nextElem;
    }
    return data;
  }
}

// {
//   "path":"",
//   "UUID":"",
//   "dataSize":0,
//   "duration":0,
//   "url":""
// }
