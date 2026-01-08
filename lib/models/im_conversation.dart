import 'im_group_at_info.dart';
import 'im_message.dart';

class ImConversation {
  /// 会话 ID
  late String conversationID;

  /// 会话类型
  int? type;

  /// 用户 ID (单聊有效)
  String? userID;

  /// 群组 ID (群聊有效)
  String? groupID;

  /// 显示名称
  String? showName;

  /// 头像 URL
  String? faceUrl;

  /// 群类型
  String? groupType;

  /// 未读计数
  int? unreadCount;

  /// 最新消息
  ImMessage? lastMessage;

  /// 草稿内容
  String? draftText;

  /// 草稿时间戳
  int? draftTimestamp;

  /// 是否置顶
  bool? isPinned;

  /// 消息接收选项
  int? recvOpt;

  /// 群 @ 信息列表
  List<ImGroupAtInfo?>? groupAtInfoList = List.empty(growable: true);

  /// 排序键
  int? orderkey;

  /// 标记列表
  List<int?>? markList;

  /// 自定义数据
  String? customData;

  /// 会话分组列表
  List<String?>? conversationGroupList;

  ImConversation({
    required this.conversationID,
    this.type,
    this.userID,
    this.groupID,
    this.showName,
    this.faceUrl,
    this.groupType,
    this.unreadCount,
    this.lastMessage,
    this.draftText,
    this.draftTimestamp,
    this.groupAtInfoList,
    this.isPinned,
    this.recvOpt,
    this.orderkey,
    this.markList,
    this.customData,
    this.conversationGroupList,
  });

  ImConversation.fromJson(Map<String, dynamic> json) {
    conversationID = json['conversationID'];
    type = json['type'];
    userID = json['userID'];
    groupID = json['groupID'];
    showName = json['showName'];
    faceUrl = json['faceUrl'];
    groupType = json['groupType'];
    unreadCount = json['unreadCount'];
    isPinned = json['isPinned'];
    recvOpt = json['recvOpt'];
    orderkey = json['orderkey'];
    lastMessage = json['lastMessage'] != null
        ? ImMessage.fromJson(json['lastMessage'])
        : null;
    draftText = json['draftText'];
    customData = json['customData'];
    draftTimestamp = json['draftTimestamp'];
    if (json['markList'] != null) {
      markList = List.empty(growable: true);
      json['markList'].forEach((v) {
        markList?.add(v);
      });
    }
    if (json['conversationGroupList'] != null) {
      conversationGroupList = List.empty(growable: true);
      json['conversationGroupList'].forEach((v) {
        conversationGroupList?.add(v);
      });
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
    data['conversationID'] = conversationID;
    data['type'] = type;
    data['userID'] = userID;
    data['groupID'] = groupID;
    data['showName'] = showName;
    data['faceUrl'] = faceUrl;
    data['groupType'] = groupType;
    data['unreadCount'] = unreadCount;
    data['isPinned'] = isPinned;
    data['recvOpt'] = recvOpt;
    data['orderkey'] = orderkey;
    data['customData'] = customData;
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage!.toJson();
    }
    data['draftText'] = draftText;
    data['draftTimestamp'] = draftTimestamp;
    if (groupAtInfoList != null) {
      data['groupAtInfoList'] = groupAtInfoList!
          .map((v) => v!.toJson())
          .toList();
    }
    if (conversationGroupList != null) {
      data['conversationGroupList'] = conversationGroupList!
          .map((v) => v)
          .toList();
    }
    if (markList != null) {
      data['markList'] = markList!.map((v) => v).toList();
    }
    return data;
  }
}

// {
//   "conversationID":"",
//   "type":0,
//   "userID":"",
//   "groupID":"",
//   "showName":"",
//   "faceUrl":"",
// "groupType":"",
// "unreadCount":0,
// "lastMessage":{},
// "draftText":"",
// "draftTimestamp":0,
// "groupAtInfoList":[{}]
// }
