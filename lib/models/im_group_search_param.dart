/// 群组搜索参数
class ImGroupSearchParam {
  /// 搜索关键字列表
  late List<String> keywordList;

  /// 是否搜索群 ID
  bool isSearchGroupID = true;

  /// 是否搜索群名称
  bool isSearchGroupName = true;

  ImGroupSearchParam({
    required this.keywordList,
    this.isSearchGroupID = true,
    this.isSearchGroupName = true,
  });

  ImGroupSearchParam.fromJson(Map<String, dynamic> json) {
    keywordList = json['keywordList'];
    isSearchGroupID = json['isSearchGroupID'];
    isSearchGroupName = json['isSearchGroupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keywordList'] = keywordList;
    data['isSearchGroupID'] = isSearchGroupID;
    data['isSearchGroupName'] = isSearchGroupName;
    return data;
  }
}
