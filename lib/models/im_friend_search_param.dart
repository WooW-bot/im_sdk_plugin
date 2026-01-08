/// V2TimFriendSearchParam
///
/// {@category Models}
///
class ImFriendSearchParam {
  /// 关键字列表
  late List<String> keywordList;

  /// 是否搜索用户 ID
  bool isSearchUserID = true;

  /// 是否搜索昵称
  bool isSearchNickName = true;

  /// 是否搜索备注
  bool isSearchRemark = true;

  ImFriendSearchParam({
    required this.keywordList,
    this.isSearchUserID = true,
    this.isSearchNickName = true,
    this.isSearchRemark = true,
  });

  ImFriendSearchParam.fromJson(Map<String, dynamic> json) {
    keywordList = json['keywordList'];
    isSearchUserID = json['isSearchUserID'];
    isSearchNickName = json['isSearchNickName'];
    isSearchRemark = json['isSearchRemark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keywordList'] = keywordList;
    data['isSearchUserID'] = isSearchUserID;
    data['isSearchNickName'] = isSearchNickName;
    data['isSearchRemark'] = isSearchRemark;
    return data;
  }
}
