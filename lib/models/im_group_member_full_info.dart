/// 群成员详细信息
class ImGroupMemberFullInfo {
  /// 用户 ID
  late String userID;

  /// 角色
  late int? role;

  /// 禁言截止时间
  late int? muteUntil;

  /// 加入时间
  late int? joinTime;

  /// 自定义信息
  Map<String, String>? customInfo;

  /// 昵称
  late String? nickName;

  /// 群名片
  late String? nameCard;

  /// 好友备注
  late String? friendRemark;

  /// 头像 URL
  late String? faceUrl;

  ImGroupMemberFullInfo({
    required this.userID,
    this.role,
    this.muteUntil,
    this.joinTime,
    this.customInfo,
    this.nickName,
    this.nameCard,
    this.friendRemark,
    this.faceUrl,
  });

  ImGroupMemberFullInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    role = json['role'];
    muteUntil = json['muteUntil'];
    joinTime = json['joinTime'];
    customInfo = json['customInfo'] == null
        ? <String, String>{}
        : Map<String, String>.from(json['customInfo']);
    nickName = json['nickName'];
    nameCard = json['nameCard'];
    friendRemark = json['friendRemark'];
    faceUrl = json['faceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['role'] = role;
    data['muteUntil'] = muteUntil;
    data['joinTime'] = joinTime;
    data['customInfo'] = customInfo;
    data['nickName'] = nickName;
    data['nameCard'] = nameCard;
    data['friendRemark'] = friendRemark;
    data['faceUrl'] = faceUrl;
    return data;
  }
}

// {
//   "userID":"",
//   "role":0,
//   "muteUntil":0,
//   "joinTime":0,
//   "customInfo":{},
//   "nickName":"",
//   "nameCard":"",
//   "friendRemark":"",
//   "faceUrl":""
// }
