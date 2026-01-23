import '../im_sdk_plugin.dart';

class ImGroupMessageReadMemberList {
  /// 下一次拉取的序列号
  late int nextSeq;

  /// 是否拉取完成
  late bool isFinished;

  /// 成员信息列表
  late List<ImGroupMemberInfo> memberInfoList;

  ImGroupMessageReadMemberList({
    required this.nextSeq,
    required this.isFinished,
    required this.memberInfoList,
  });

  ImGroupMessageReadMemberList.fromJson(Map<String, dynamic> json) {
    nextSeq = json['nextSeq'];
    isFinished = json['isFinished'];
    if (json['memberInfoList'] != null) {
      memberInfoList = List.empty(growable: true);
      json['memberInfoList'].forEach((v) {
        memberInfoList.add(ImGroupMemberInfo.fromJson(v));
      });
    } else {
      memberInfoList = List.empty(growable: true);
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextSeq'] = nextSeq;
    data['isFinished'] = isFinished;
    data['memberInfoList'] = memberInfoList.isNotEmpty
        ? memberInfoList.map((v) => v.toJson()).toList()
        : [];
    return data;
  }
}
