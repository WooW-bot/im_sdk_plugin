import '../im_sdk_plugin.dart';
import 'im_group_at_info.dart';

class ImTopicInfo {
  /// 话题 ID
  String? topicID;

  /// 话题名称
  String? topicName;

  /// 话题头像 URL
  String? topicFaceUrl;

  /// 话题简介
  String? introduction;

  /// 话题公告
  String? notification;

  /// 是否全员禁言
  bool? isAllMute = false;

  /// 自己被禁言时间
  int? selfMuteTime;

  /// 自定义字符串
  String? customString;

  /// 消息接收选项
  int? recvOpt;

  /// 草稿文本
  String? draftText;

  /// 未读数
  int? unreadCount = 0;

  /// 最后一条消息
  ImMessage? lastMessage;

  /// 群 @ 信息列表
  List<ImGroupAtInfo>? groupAtInfoList = List.empty(growable: true);

  ImTopicInfo({
    this.topicID,
    this.topicName,
    this.topicFaceUrl,
    this.introduction,
    this.notification,
    this.isAllMute,
    this.selfMuteTime,
    this.customString,
    this.draftText,
    this.unreadCount,
    this.lastMessage,
    this.groupAtInfoList,
  });

  ImTopicInfo.fromJson(Map<String, dynamic> json) {
    topicID = json['topicID'];
    topicName = json['topicName'];
    topicFaceUrl = json['topicFaceUrl'];
    introduction = json['introduction'];
    notification = json['notification'];
    isAllMute = json['isAllMute'];
    selfMuteTime = json['selfMuteTime'];
    customString = json['customString'];
    draftText = json['draftText'];
    unreadCount = json['unreadCount'];
    if (json['lastMessage'] != null) {
      lastMessage = ImMessage.fromJson(json['lastMessage']);
    }
    if (json['groupAtInfoList'] != null) {
      groupAtInfoList = List.empty(growable: true);
      json['groupAtInfoList'].forEach((v) {
        groupAtInfoList!.add(ImGroupAtInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicID'] = topicID;
    data['topicName'] = topicName;
    data['topicFaceUrl'] = topicFaceUrl;
    data['introduction'] = introduction;
    data['notification'] = notification;
    data['isAllMute'] = isAllMute;
    data['selfMuteTime'] = selfMuteTime;
    data['customString'] = customString;
    data['draftText'] = draftText;
    data['unreadCount'] = unreadCount;
    data['lastMessage'] = lastMessage?.toJson();
    if (groupAtInfoList != null) {
      data['groupAtInfoList'] = groupAtInfoList!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}
