import 'im_message_search_result_item.dart';

class ImMessageSearchResult {
  /// 总数量
  int? totalCount;

  /// 搜索结果项列表
  List<ImMessageSearchResultItem>? messageSearchResultItems;

  ImMessageSearchResult({this.totalCount, this.messageSearchResultItems});

  ImMessageSearchResult.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['messageSearchResultItems'] != null) {
      messageSearchResultItems = List.empty(growable: true);
      json['messageSearchResultItems'].forEach((v) {
        messageSearchResultItems!.add(ImMessageSearchResultItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (messageSearchResultItems != null) {
      data['messageSearchResultItems'] = messageSearchResultItems!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

// {
//   "userID":"",
//   "timestamp":0
// }
