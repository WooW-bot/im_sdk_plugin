import 'im_group_member_full_info.dart';

class ImGroupMemberInfoResult {
  /// 下一次拉取的序列号
  late String? nextSeq;

  /// 成员信息列表
  List<ImGroupMemberFullInfo?>? memberInfoList = List.empty(growable: true);

  ImGroupMemberInfoResult({this.nextSeq, this.memberInfoList});

  ImGroupMemberInfoResult.fromJson(Map<String, dynamic> json) {
    nextSeq = json['nextSeq'];
    if (json['memberInfoList'] != null) {
      memberInfoList = List.empty(growable: true);
      json['memberInfoList'].forEach((v) {
        memberInfoList!.add(ImGroupMemberFullInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextSeq'] = nextSeq;
    if (memberInfoList != null) {
      data['memberInfoList'] = memberInfoList!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

// {
//   "nextSeq":0,
//   "memberInfoList":[{}]
// }
