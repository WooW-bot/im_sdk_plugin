/// V2TimGroupMemberSearchParam
///
/// {@category Models}
///
class ImGroupMemberSearchParam {
  /// 搜索关键字列表，最多支持5个
  late List<String> keywordList;

  /// 搜索群 ID 列表，为空表示搜索所有群
  List<String>? groupIDList;

  /// 是否搜索群成员用户 ID
  bool isSearchMemberUserID = true;

  /// 是否搜索群成员昵称
  bool isSearchMemberNickName = true;

  /// 是否搜索群成员备注
  bool isSearchMemberRemark = true;

  /// 是否搜索群成员名片
  bool isSearchMemberNameCard = true;

  ImGroupMemberSearchParam({
    required this.keywordList,
    this.groupIDList,
    this.isSearchMemberUserID = true,
    this.isSearchMemberNickName = true,
    this.isSearchMemberRemark = true,
    this.isSearchMemberNameCard = true,
  });

  ImGroupMemberSearchParam.fromJson(Map<String, dynamic> json) {
    keywordList = json['keywordList'];
    groupIDList = json['groupIDList'];
    isSearchMemberUserID = json['isSearchMemberUserID'];
    isSearchMemberNickName = json['isSearchMemberNickName'];
    isSearchMemberRemark = json['isSearchMemberRemark'];
    isSearchMemberNameCard = json['isSearchMemberNameCard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keywordList'] = keywordList;
    data['groupIDList'] = groupIDList;
    data['isSearchMemberUserID'] = isSearchMemberUserID;
    data['isSearchMemberNickName'] = isSearchMemberNickName;
    data['isSearchMemberRemark'] = isSearchMemberRemark;
    data['isSearchMemberNameCard'] = isSearchMemberNameCard;
    return data;
  }
}
