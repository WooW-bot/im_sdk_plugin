import 'im_group_member_full_info.dart';

class GroupMemberInfoSearchResult {
  /// 群成员搜索结果项
  Map<String, dynamic>? groupMemberSearchResultItems;

  GroupMemberInfoSearchResult({this.groupMemberSearchResultItems});

  GroupMemberInfoSearchResult.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> myMap = {};
    json.forEach((key, value) {
      var tempArr = [];
      if (value is List) {
        for (var element in value) {
          tempArr.add(ImGroupMemberFullInfo.fromJson(element));
        }
        myMap[key] = tempArr;
      }
    });
    groupMemberSearchResultItems = myMap;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (groupMemberSearchResultItems != null) {
      var map = groupMemberSearchResultItems;
      var newMap = {};
      map?.forEach((key, value) {
        newMap[key] = value.map((v) => v.toJson()).toList();
      });
      data['messageSearchResultItems'] = newMap;
    }
    return data;
  }
}
