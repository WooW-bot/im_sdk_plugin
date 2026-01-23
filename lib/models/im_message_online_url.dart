import '../im_sdk_plugin.dart';

/// 消息在线 URL
class ImMessageOnlineUrl {
  /// 图片元素
  ImImageElem? imageElem;

  /// 语音元素
  ImSoundElem? soundElem;

  /// 视频元素
  ImVideoElem? videoElem;

  /// 文件元素
  ImFileElem? fileElem;

  ImMessageOnlineUrl({this.imageElem, this.soundElem, this.videoElem, this.fileElem});

  ImMessageOnlineUrl.fromJson(Map<String, dynamic> json) {
    imageElem = json['imageElem'] != null ? ImImageElem.fromJson(json['imageElem']) : null;
    soundElem = json['soundElem'] != null ? ImSoundElem.fromJson(json['soundElem']) : null;
    videoElem = json['videoElem'] != null ? ImVideoElem.fromJson(json['videoElem']) : null;
    fileElem = json['fileElem'] != null ? ImFileElem.fromJson(json['fileElem']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageElem'] = imageElem?.toJson();
    data['soundElem'] = soundElem?.toJson();
    data['videoElem'] = videoElem?.toJson();
    data['fileElem'] = fileElem?.toJson();
    return data;
  }
}

// {
//   "userID":"",
//   "timestamp":0
// }
