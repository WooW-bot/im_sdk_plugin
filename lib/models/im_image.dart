class ImImage {
  // ignore: non_constant_identifier_names
  /// 图片 UUID
  late String? uuid;

  /// 图片类型
  late int? type;

  /// 图片大小
  late int? size;

  /// 图片宽度
  late int? width;

  /// 图片高度
  late int? height;

  /// 图片下载 URL
  late String? url;

  /// 图片本地 URL
  String? localUrl;

  ImImage({
    // ignore: non_constant_identifier_names
    this.uuid,
    required this.type,
    this.size,
    this.width,
    this.height,
    this.url,
    this.localUrl,
  });

  ImImage.fromJson(Map<String, dynamic> json) {
    uuid = json['UUID'] ?? json['uuid'];
    type = json['type'];
    size = json['size'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    localUrl = json['localUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['type'] = type;
    data['size'] = size;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['localUrl'] = localUrl;
    return data;
  }
}

// {
//   "UUID":"",
//   "type":0,
//   "size":0,
//   "width":0,
//   "height":0,
//   "url":""
// }
