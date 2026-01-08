import 'im_group_application.dart';

class ImGroupApplicationResult {
  /// 未读数
  late int? unreadCount = 0;

  /// 群申请列表
  List<ImGroupApplication?>? groupApplicationList = List.empty(growable: true);

  ImGroupApplicationResult({this.unreadCount, this.groupApplicationList});

  ImGroupApplicationResult.fromJson(Map<String, dynamic> json) {
    unreadCount = json['unreadCount'];
    if (json['groupApplicationList'] != null) {
      groupApplicationList = List.empty(growable: true);
      json['groupApplicationList'].forEach((v) {
        groupApplicationList!.add(ImGroupApplication.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unreadCount'] = unreadCount;
    if (groupApplicationList != null) {
      data['groupApplicationList'] = groupApplicationList!
          .map((v) => v!.toJson())
          .toList();
    }
    return data;
  }
}

// {
//   "unreadCount":0,
//   "groupApplicationList":[]
// }
