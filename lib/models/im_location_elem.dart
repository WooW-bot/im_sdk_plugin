import 'im_elem.dart';

class ImLocationElem extends IMElem {
  /// 地理位置描述
  late String? desc;

  /// 经度
  late double longitude;

  /// 纬度
  late double latitude;

  ImLocationElem({this.desc, required this.longitude, required this.latitude});

  ImLocationElem.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    if (json['nextElem'] != null) {
      nextElem = Map<String, dynamic>.from(json['nextElem']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['desc'] = desc;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    if (nextElem != null) {
      data['nextElem'] = nextElem;
    }
    return data;
  }
}
