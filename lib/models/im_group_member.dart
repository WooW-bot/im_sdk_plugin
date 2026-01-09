import '../enum/group_member_role_enum.dart';
import '../enum/utils.dart';

/// 群成员
class ImGroupMember {
  /// 用户 ID
  late String userID;

  /// 群成员角色
  late GroupMemberRoleTypeEnum role;

  ImGroupMember({required this.userID, required this.role});

  fromJson(String userID, GroupMemberRoleTypeEnum role) {
    this.userID = userID;
    this.role = role;
  }

  Map<dynamic, dynamic> toJson() {
    return {"userID": userID, "role": EnumUtils.convertGroupMemberRoleTypeEnum(role)};
  }
}
