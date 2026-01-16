/// 用户详细信息
class ImUserFullInfo {
  /// 用户 ID
  late String? userId;

  /// 昵称
  late String? nickName;

  /// 头像 URL
  late String? faceUrl;

  /// 签名
  late String? selfSignature;

  /// 性别
  late int? gender;

  /// 加好友验证方式
  late int? friendAllowType;

  /// 生日
  late String? birthday;

  /// 地址
  late String? location;

  /// 扩展字段 (JSON)
  late String? extra;

  ImUserFullInfo({
    this.userId,
    this.nickName,
    this.faceUrl,
    this.selfSignature,
    this.gender,
    this.friendAllowType,
    this.birthday,
    this.location,
    this.extra,
  });

  ImUserFullInfo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    nickName = json['nickName'];
    faceUrl = json['faceUrl'];
    selfSignature = json['selfSignature'];
    gender = json['gender'];
    friendAllowType = json['friendAllowType'];
    birthday = json['birthday'];
    location = json['location'];
    extra = json['extra'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['nickName'] = nickName;
    data['faceUrl'] = faceUrl;
    data['selfSignature'] = selfSignature;
    data['gender'] = gender;
    data['friendAllowType'] = friendAllowType;
    data['birthday'] = birthday;
    data['location'] = location;
    data['extra'] = extra;
    return data;
  }
}

// {
//   "userID":"",
//   "nickName":"",
//   "faceUrl":"",
//   "selfSignature":"",
//   "gender":0,
//   "allowType":0,
//   "customInfo":{"test":""},
//   "role":0,
//   "level":0
// }
