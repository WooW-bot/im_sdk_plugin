class ImGroupInfo {
  /// 群组 ID
  late String groupID;

  /// 群类型
  late String groupType;

  /// 群名称
  late String? groupName;

  /// 群公告
  late String? notification;

  /// 群简介
  late String? introduction;

  /// 群头像 URL
  late String? faceUrl;

  /// 是否全员禁言
  late bool? isAllMuted;

  /// 是否支持话题
  bool? isSupportTopic = false;

  /// 群主 ID
  late String? owner;

  /// 创建时间
  late int? createTime;

  /// 加群选项
  late int? groupAddOpt;

  /// 最后修改群信息时间
  late int? lastInfoTime;

  /// 最后一条消息时间
  late int? lastMessageTime;

  /// 成员数量
  late int? memberCount;

  /// 在线成员数量
  late int? onlineCount;

  /// 角色
  late int? role;

  /// 消息接收选项
  late int? recvOpt;

  /// 加入时间
  late int? joinTime;

  /// 自定义信息
  Map<String, String>? customInfo;

  ImGroupInfo({
    required this.groupID,
    required this.groupType,
    this.groupName,
    this.notification,
    this.introduction,
    this.faceUrl,
    this.isAllMuted,
    this.owner,
    this.createTime,
    this.groupAddOpt,
    this.lastInfoTime,
    this.lastMessageTime,
    this.memberCount,
    this.onlineCount,
    this.role,
    this.recvOpt,
    this.joinTime,
    this.isSupportTopic,
    this.customInfo,
  });

  ImGroupInfo.fromJson(Map<String, dynamic> json) {
    groupID = json['groupID'];
    groupType = json['groupType'];
    groupName = json['groupName'];
    notification = json['notification'];
    introduction = json['introduction'];
    faceUrl = json['faceUrl'];
    isAllMuted = json['isAllMuted'];
    owner = json['owner'];
    createTime = json['createTime'];
    groupAddOpt = json['groupAddOpt'];
    lastInfoTime = json['lastInfoTime'];
    lastMessageTime = json['lastMessageTime'];
    memberCount = json['memberCount'];
    onlineCount = json['onlineCount'];
    isSupportTopic = json["isSupportTopic"];
    role = json['role'];
    recvOpt = json['recvOpt'];
    joinTime = json['joinTime'];
    customInfo = json['customInfo'] == null
        ? <String, String>{}
        : Map<String, String>.from(json['customInfo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupID'] = groupID;
    data['groupType'] = groupType;
    data['groupName'] = groupName;
    data['notification'] = notification;
    data['introduction'] = introduction;
    data['faceUrl'] = faceUrl;
    data['isAllMuted'] = isAllMuted;
    data['owner'] = owner;
    data['createTime'] = createTime;
    data['groupAddOpt'] = groupAddOpt;
    data['lastInfoTime'] = lastInfoTime;
    data['lastMessageTime'] = lastMessageTime;
    data['memberCount'] = memberCount;
    data['onlineCount'] = onlineCount;
    data['role'] = role;
    data['recvOpt'] = recvOpt;
    data['joinTime'] = joinTime;
    data['customInfo'] = customInfo;
    data['isSupportTopic'] = isSupportTopic;
    return data;
  }
}

// {
//  "groupID":"" ,
//  "groupType":"",
//  "groupName":"",
//  "notification":"",
//  "introduction":"",
//  "faceUrl":"",
//  "allMuted":false,
//  "owner":"",
//  "createTime":0,
//  "groupAddOpt":0,
//  "lastInfoTime":0,
//  "lastMessageTime":0,
//  "memberCount":0,
//  "onlineCount":0,
//  "role":0,
//  "recvOpt":0,
//  "joinTime":0,
//  "customInfo":{}
// }
