/// 群成员基本信息
class ImGroupMemberInfo {
  /// 用户 ID
  String? userID;

  /// 昵称
  String? nickName;

  /// 群名片
  String? nameCard;

  /// 好友备注
  String? friendRemark;

  /// 头像 URL
  String? faceUrl;

  ImGroupMemberInfo({this.userID, this.nickName, this.nameCard, this.friendRemark, this.faceUrl});

  ImGroupMemberInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    nickName = json['nickName'];
    nameCard = json['nameCard'];
    friendRemark = json['friendRemark'];
    faceUrl = json['faceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['nickName'] = nickName;
    data['nameCard'] = nameCard;
    data['friendRemark'] = friendRemark;
    data['faceUrl'] = faceUrl;
    return data;
  }
}

// {
//   "userID":"",
//   "nickName":"",
//   "nameCard":"",
//   "friendRemark":"",
//   "faceUrl":""
// }
