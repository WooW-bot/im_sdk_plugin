import '../enums/group_member_role_enum.dart';
import '../utils/utils.dart';

/// 群成员
class ImGroupMember {
  /// 群ID
  late String? groupID;

  /// 用户ID
  late String userID;

  /// 群成员角色
  late GroupMemberRoleTypeEnum role;

  /// 禁言结束时间
  late int? muteEndTime;

  /// 群名片
  late String? alias;

  /// 入群时间
  late int? joinTime;

  /// 入群方式
  late String? joinType;

  /// 扩展字段
  late String? ex;

  /// 用户昵称 (Join from User info)
  late String? nickname;

  /// 用户头像 (Join from User info)
  late String? faceUrl;

  ImGroupMember({
    this.groupID,
    required this.userID,
    required this.role,
    this.muteEndTime,
    this.alias,
    this.joinTime,
    this.joinType,
    this.ex,
    this.nickname,
    this.faceUrl,
  });

  ImGroupMember.fromJson(Map<String, dynamic> json) {
    groupID = json['group_id'];
    userID = json['member_id'] ?? json['userID']; // Handle DB vs Network keys
    // EnumUtils.groupMemberRoleTypeEnum does not exist, assume direct integer casting or create method
    // For now assuming integer role
    int roleInt = json['role'] ?? 0;
    role = GroupMemberRoleTypeEnum.values.firstWhere(
      (e) => e.index == roleInt,
      orElse: () => GroupMemberRoleTypeEnum.IM_GROUP_MEMBER_ROLE_MEMBER,
    );

    muteEndTime = json['mute_end_time'] ?? json['muteEndTime'];
    alias = json['alias'];
    joinTime = json['join_time'] ?? json['joinTime'];
    joinType = json['join_type'] ?? json['joinType'];
    ex = json['ex'];
    // Derived fields
    nickname = json['nick_name'] ?? json['nickname'];
    faceUrl = json['face_url'] ?? json['faceUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      "group_id": groupID,
      "member_id": userID,
      "role": EnumUtils.convertGroupMemberRoleTypeEnum(role),
      "mute_end_time": muteEndTime,
      "alias": alias,
      "join_time": joinTime,
      "join_type": joinType,
      "ex": ex,
      "nickname": nickname,
      "faceUrl": faceUrl,
    };
  }
}
