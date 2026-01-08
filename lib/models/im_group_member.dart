import '../enum/group_member_role_enum.dart';
import '../enum/utils.dart';

class ImGroupMember {
  late String userID;
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
