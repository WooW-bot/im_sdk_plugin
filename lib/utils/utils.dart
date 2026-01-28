import '../enums/group_member_role.dart';
import '../im_sdk_plugin.dart';

/// 枚举工具类
class EnumUtils {
  /// 转换群成员角色枚举
  static int convertGroupMemberRoleTypeEnum(GroupMemberRoleTypeEnum role) {
    if (role == GroupMemberRoleTypeEnum.IM_GROUP_MEMBER_ROLE_ADMIN) {
      return GroupMemberRoleType.IM_GROUP_MEMBER_ROLE_ADMIN;
    }
    if (role == GroupMemberRoleTypeEnum.IM_GROUP_MEMBER_ROLE_MEMBER) {
      return GroupMemberRoleType.IM_GROUP_MEMBER_ROLE_MEMBER;
    }
    if (role == GroupMemberRoleTypeEnum.IM_GROUP_MEMBER_ROLE_OWNER) {
      return GroupMemberRoleType.IM_GROUP_MEMBER_ROLE_OWNER;
    }
    if (role == GroupMemberRoleTypeEnum.IM_GROUP_MEMBER_UNDEFINED) {
      return GroupMemberRoleType.IM_GROUP_MEMBER_UNDEFINED;
    }
    return GroupMemberRoleType.IM_GROUP_MEMBER_UNDEFINED;
  }
}
