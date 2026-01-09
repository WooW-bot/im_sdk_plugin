import 'im_group_change_info.dart';
import 'im_group_member_change_info.dart';
import 'im_group_member_info.dart';

/// 群提示消息元素
class ImGroupTipsElem {
  /// 群组 ID
  late String groupID;

  /// 提示类型
  late int type;

  /// 操作者信息
  late ImGroupMemberInfo opMember;

  /// 被操作者列表
  List<ImGroupMemberInfo?>? memberList = List.empty(growable: true);

  /// 群信息变更列表
  List<ImGroupChangeInfo?>? groupChangeInfoList = List.empty(growable: true);

  /// 群成员变更列表
  List<ImGroupMemberChangeInfo?>? memberChangeInfoList = List.empty(growable: true);

  /// 成员数量
  late int? memberCount;

  ImGroupTipsElem({
    required this.groupID,
    required this.type,
    required this.opMember,
    this.memberList,
    this.groupChangeInfoList,
    this.memberChangeInfoList,
    this.memberCount,
  });

  ImGroupTipsElem.fromJson(Map<String, dynamic> json) {
    groupID = json['groupID'];
    type = json['type'];
    opMember = ImGroupMemberInfo.fromJson(json['opMember']);
    if (json['memberList'] != null) {
      memberList = List.empty(growable: true);
      json['memberList'].forEach((v) {
        memberList!.add(ImGroupMemberInfo.fromJson(v));
      });
    }
    if (json['groupChangeInfoList'] != null) {
      groupChangeInfoList = List.empty(growable: true);
      json['groupChangeInfoList'].forEach((v) {
        groupChangeInfoList!.add(ImGroupChangeInfo.fromJson(v));
      });
    }
    if (json['memberChangeInfoList'] != null) {
      memberChangeInfoList = List.empty(growable: true);
      json['memberChangeInfoList'].forEach((v) {
        memberChangeInfoList!.add(ImGroupMemberChangeInfo.fromJson(v));
      });
    }
    memberCount = json['memberCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupID'] = groupID;
    data['type'] = type;
    data['opMember'] = opMember.toJson();
    if (memberList != null) {
      data['memberList'] = memberList!.map((v) => v!.toJson()).toList();
    }
    if (groupChangeInfoList != null) {
      data['groupChangeInfoList'] = groupChangeInfoList!.map((v) => v!.toJson()).toList();
    }
    if (memberChangeInfoList != null) {
      data['memberChangeInfoList'] = memberChangeInfoList!.map((v) => v!.toJson()).toList();
    }
    data['memberCount'] = memberCount;
    return data;
  }
}

// {
//   "groupID":"",
//   "type":0,
//   "opMember":{},
//   "memberList":[{}],
//   "groupChangeInfoList":[{}],
//   "memberChangeInfoList":[{}],
//   "memberCount":0
// }
