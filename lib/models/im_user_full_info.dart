/// 用户详细信息
class ImUserFullInfo {
  /// 用户 ID
  late String? userID;

  /// 昵称
  late String? nickName;

  /// 头像 URL
  late String? faceUrl;

  /// 签名
  late String? selfSignature;

  /// 性别
  late int? gender;

  /// 加好友验证方式
  late int? allowType;

  /// 自定义信息
  late Map<String, String>? customInfo;

  /// 角色
  late int? role;

  /// 等级
  late int? level;

  /// 生日
  late int? birthday;

  ImUserFullInfo({
    this.userID,
    this.nickName,
    this.faceUrl,
    this.selfSignature,
    this.gender,
    this.allowType,
    this.customInfo,
    this.role,
    this.level,
    this.birthday,
  });

  ImUserFullInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    nickName = json['nickName'];
    faceUrl = json['faceUrl'];
    selfSignature = json['selfSignature'];
    gender = json['gender'];
    allowType = json['allowType'];
    customInfo = json['customInfo'] == null
        ? <String, String>{}
        : Map<String, String>.from(json['customInfo']);
    role = json['role'];
    level = json['level'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['nickName'] = nickName;
    data['faceUrl'] = faceUrl;
    data['selfSignature'] = selfSignature;
    data['gender'] = gender;
    data['allowType'] = allowType;
    data['customInfo'] = customInfo;
    data['role'] = role;
    data['level'] = level;
    data['birthday'] = birthday;
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
