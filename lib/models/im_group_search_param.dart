/// V2TimGroupSearchParam
///
/// {@category Models}
///
class ImGroupSearchParam {
  late List<String> keywordList;
  bool isSearchGroupID = true;
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
