import 'offline_push_info.dart';
import 'im_custom_elem.dart';
import 'im_face_elem.dart';
import 'im_file_elem.dart';
import 'im_group_tips_elem.dart';
import 'im_image_elem.dart';
import 'im_location_elem.dart';
import 'im_merger_elem.dart';
import 'im_sound_elem.dart';
import 'im_text_elem.dart';
import 'im_video_elem.dart';

class ImMessage {
  /// 消息 ID
  late String? msgID;

  /// 时间戳
  late int? timestamp;

  /// 进度
  late int? progress;

  /// 发送者 ID
  late String? sender;

  /// 发送者昵称
  late String? nickName;

  /// 好友备注
  late String? friendRemark;

  /// 头像 URL
  late String? faceUrl;

  /// 群名片
  late String? nameCard;

  /// 群组 ID
  late String? groupID;

  /// 用户 ID
  late String? userID;

  /// 消息状态
  late int? status;

  /// 元素类型
  late int elemType;

  /// 文本元素
  ImTextElem? textElem;

  /// 自定义元素
  ImCustomElem? customElem;

  /// 图片元素
  ImImageElem? imageElem;

  /// 语音元素
  ImSoundElem? soundElem;

  /// 视频元素
  ImVideoElem? videoElem;

  /// 文件元素
  ImFileElem? fileElem;

  /// 位置元素
  ImLocationElem? locationElem;

  /// 表情元素
  ImFaceElem? faceElem;

  /// 群提示元素
  ImGroupTipsElem? groupTipsElem;

  /// 合并消息元素
  ImMergerElem? mergerElem;

  /// 本地自定义数据
  late String? localCustomData;

  /// 本地自定义整数
  late int? localCustomInt;

  /// 云端自定义数据
  late String? cloudCustomData;

  /// 是否是自己发送
  late bool? isSelf;

  /// 是否已读
  late bool? isRead;

  /// 对方是否已读
  late bool? isPeerRead;

  /// 优先级
  late int? priority;

  /// 离线推送信息
  OfflinePushInfo? offlinePushInfo;

  /// 群 @ 用户列表
  List<String>? groupAtUserList = List.empty(growable: true);

  /// 序列号
  late String? seq;

  /// 随机数
  late int? random;

  /// 是否不计入未读数
  late bool? isExcludedFromUnreadCount;

  /// 是否不作为最后一条消息
  late bool? isExcludedFromLastMessage;

  /// 是否支持消息扩展
  late bool? isSupportMessageExtension;

  /// Web 端消息来源
  late String? messageFromWeb;

  /// 内部 ID (plugin 维护, 在 onProgressListener 的监听中才返回)
  late String? id;

  /// 是否需要回执
  late bool? needReadReceipt;

  ImMessage({
    this.msgID,
    this.timestamp,
    this.progress,
    this.sender,
    this.nickName,
    this.friendRemark,
    this.faceUrl,
    this.nameCard,
    this.groupID,
    this.userID,
    this.status,
    required this.elemType,
    this.textElem,
    this.customElem,
    this.imageElem,
    this.soundElem,
    this.videoElem,
    this.fileElem,
    this.locationElem,
    this.faceElem,
    this.groupTipsElem,
    this.mergerElem,
    this.localCustomData,
    this.localCustomInt,
    this.cloudCustomData,
    this.isSelf,
    this.isRead,
    this.isPeerRead,
    this.priority,
    this.offlinePushInfo,
    this.groupAtUserList,
    this.seq,
    this.random,
    this.isExcludedFromUnreadCount,
    this.isExcludedFromLastMessage,
    this.isSupportMessageExtension,
    this.messageFromWeb,
    this.id,
    this.needReadReceipt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImMessage &&
          runtimeType == other.runtimeType &&
          msgID == other.msgID &&
          id == other.id &&
          status == other.status;

  @override
  int get hashCode => msgID.hashCode + id.hashCode + status.hashCode;

  ImMessage.fromJson(Map<String, dynamic> json) {
    msgID = json['msgID'];
    timestamp = json['timestamp'];
    progress = json['progress'];
    sender = json['sender'];
    nickName = json['nickName'];
    friendRemark = json['friendRemark'];
    faceUrl = json['faceUrl'];
    nameCard = json['nameCard'];
    groupID = json['groupID'];
    userID = json['userID'];
    status = json['status'];
    elemType = json['elemType'];
    id = json['id'];
    needReadReceipt = json['needReadReceipt'];
    textElem = json['textElem'] != null
        ? ImTextElem.fromJson(json['textElem'])
        : null;
    customElem = json['customElem'] != null
        ? ImCustomElem.fromJson(json['customElem'])
        : null;
    imageElem = json['imageElem'] != null
        ? ImImageElem.fromJson(json['imageElem'])
        : null;
    soundElem = json['soundElem'] != null
        ? ImSoundElem.fromJson(json['soundElem'])
        : null;
    videoElem = json['videoElem'] != null
        ? ImVideoElem.fromJson(json['videoElem'])
        : null;
    fileElem = json['fileElem'] != null
        ? ImFileElem.fromJson(json['fileElem'])
        : null;
    locationElem = json['locationElem'] != null
        ? ImLocationElem.fromJson(json['locationElem'])
        : null;
    faceElem = json['faceElem'] != null
        ? ImFaceElem.fromJson(json['faceElem'])
        : null;
    groupTipsElem = json['groupTipsElem'] != null
        ? ImGroupTipsElem.fromJson(json['groupTipsElem'])
        : null;
    mergerElem = json['mergerElem'] != null
        ? ImMergerElem.fromJson(json['mergerElem'])
        : null;
    localCustomData = json['localCustomData'] ?? "";
    localCustomInt = json['localCustomInt'];
    cloudCustomData = json['cloudCustomData'] ?? "";
    isSelf = json['isSelf'];
    isRead = json['isRead'];
    isPeerRead = json['isPeerRead'];
    priority = json['priority'];
    offlinePushInfo = json['offlinePushInfo'] != null
        ? OfflinePushInfo.fromJson(json['offlinePushInfo'])
        : null;
    groupAtUserList = json['groupAtUserList'] != null
        ? json['groupAtUserList'].cast<String>()
        : List.empty(growable: true);
    seq = json['seq'];
    random = json['random'];
    isExcludedFromUnreadCount = json['isExcludedFromUnreadCount'];
    isExcludedFromLastMessage = json['isExcludedFromLastMessage'];
    isSupportMessageExtension = json["isSupportMessageExtension"];
    messageFromWeb = json['messageFromWeb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msgID'] = msgID;
    data['timestamp'] = timestamp;
    data['progress'] = progress;
    data['sender'] = sender;
    data['nickName'] = nickName;
    data['friendRemark'] = friendRemark;
    data['faceUrl'] = faceUrl;
    data['nameCard'] = nameCard;
    data['groupID'] = groupID;
    data['userID'] = userID;
    data['status'] = status;
    data['elemType'] = elemType;
    data['id'] = id;
    data['needReadReceipt'] = needReadReceipt;
    if (textElem != null) {
      data['textElem'] = textElem!.toJson();
    }
    if (customElem != null) {
      data['customElem'] = customElem!.toJson();
    }
    if (imageElem != null) {
      data['imageElem'] = imageElem!.toJson();
    }
    if (soundElem != null) {
      data['soundElem'] = soundElem!.toJson();
    }
    if (videoElem != null) {
      data['videoElem'] = videoElem!.toJson();
    }
    if (fileElem != null) {
      data['fileElem'] = fileElem!.toJson();
    }
    if (locationElem != null) {
      data['locationElem'] = locationElem!.toJson();
    }
    if (faceElem != null) {
      data['faceElem'] = faceElem!.toJson();
    }
    if (groupTipsElem != null) {
      data['groupTipsElem'] = groupTipsElem!.toJson();
    }
    if (mergerElem != null) {
      data['mergerElem'] = mergerElem!.toJson();
    }
    data['localCustomData'] = localCustomData;
    data['localCustomInt'] = localCustomInt;
    data['cloudCustomData'] = cloudCustomData;

    data['isSelf'] = isSelf;
    data['isRead'] = isRead;
    data['isPeerRead'] = isPeerRead;
    data['priority'] = priority;
    if (offlinePushInfo != null) {
      data['offlinePushInfo'] = offlinePushInfo!.toJson();
    }
    if (groupAtUserList != null) {
      data['groupAtUserList'] = groupAtUserList;
    }
    data['seq'] = seq;
    data['random'] = random;
    data['isExcludedFromUnreadCount'] = isExcludedFromUnreadCount;
    data['isExcludedFromLastMessage'] = isExcludedFromLastMessage;
    data["isSupportMessageExtension"] = isSupportMessageExtension;
    data['messageFromWeb'] = messageFromWeb;
    return data;
  }
}

// {
//   "msgID":"",
//     "timestamp":0,
//     "progress":100,
//     "sender":"",
//     "nickName":"",
//     "friendRemark":"",
//     "faceUrl":"",
//     "nameCard":"",
//     "groupID":"",
//     "userID":"",
//     "status":1,
//     "elemType":1,
//     "textElem":{},
//     "customElem":{},
//     "imageElem":{},
//     "soundElem":{},
//     "videoElem":{},
//     "fileElem":{},
//     "locationElem":{},
//     "faceElem":{},
//     "groupTipsElem":{},
//     "mergerElem":{},
//     "localCustomData":"",
//     "localCustomInt":0,
//     "isSelf":false,
//     "isRead":false,
//     "isPeerRead":false,
//     "priority":0,
//     "offlinePushInfo":{},
//     "groupAtUserList":[{}],
//     "seq":0,
//     "random":0,
//     "isExcludedFromUnreadCount":false
// }
