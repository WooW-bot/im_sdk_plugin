/// 离线推送配置信息
class OfflinePushInfo {
  /// 推送标题
  late String? title;

  /// 推送内容
  late String? desc;

  /// 推送扩展字段
  String? ext;

  /// 是否禁用推送
  late bool? disablePush;

  /// iOS 离线推送声音
  late String? iOSSound;

  /// iOS 忽略角标计数
  late bool? ignoreIOSBadge;

  /// Android OPPO 渠道 ID
  late String? androidOPPOChannelID;

  /// Android VIVO 推送类别
  late String? androidVIVOClassification;

  /// Android 离线推送声音
  late String? androidSound;

  OfflinePushInfo({
    this.title,
    this.desc,
    this.disablePush,
    this.iOSSound,
    this.ignoreIOSBadge,
    this.androidOPPOChannelID,
    this.ext,
    this.androidSound,
    this.androidVIVOClassification,
  });

  OfflinePushInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    ext = json['ext'];
    disablePush = json['disablePush'];
    iOSSound = json['iOSSound'];
    ignoreIOSBadge = json['ignoreIOSBadge'];
    androidOPPOChannelID = (json['androidOPPOChannelID'] ?? "").toString();
    androidSound = (json['androidSound'] ?? "").toString();
    androidVIVOClassification = (json['androidVIVOClassification'] ?? "")
        .toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    data['ext'] = ext;
    data['disablePush'] = disablePush;
    data['iOSSound'] = iOSSound;
    data['ignoreIOSBadge'] = ignoreIOSBadge;
    data['androidOPPOChannelID'] = androidOPPOChannelID;
    data['androidSound'] = androidSound;
    data['androidVIVOClassification'] = androidVIVOClassification;
    return data;
  }
}
