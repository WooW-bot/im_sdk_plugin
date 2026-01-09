import '../enums/group_add_opt_enum.dart';
import '../enums/group_application_type_enum.dart';
import '../enums/group_member_filter_enum.dart';
import '../enums/group_member_role_enum.dart';
import '../models/im_callback.dart';
import '../models/im_group_application_result.dart';
import '../models/im_group_info.dart';
import '../models/im_group_info_result.dart';
import '../models/im_group_member.dart';
import '../models/im_group_member_full_info.dart';
import '../models/im_group_member_info_result.dart';
import '../models/im_group_member_operation_result.dart';
import '../models/im_group_member_search_param.dart';
import '../models/im_group_member_search_result.dart';
import '../models/im_group_search_param.dart';
import '../models/im_topic_info.dart';
import '../models/im_topic_info_result.dart';
import '../models/im_topic_operation_result.dart';
import '../models/im_value_callback.dart';

/// 群组管理器
class IMGroupManager {
  /// 创建群组
  Future<ImValueCallback<String>> createGroup({
    String? groupID,
    required String groupType,
    required String groupName,
    String? notification,
    String? introduction,
    String? faceUrl,
    bool? isAllMuted,
    bool? isSupportTopic = false,
    GroupAddOptTypeEnum? addOpt,
    List<ImGroupMember>? memberList,
  }) async {
    // TODO: implement createGroup
    throw UnimplementedError();
  }

  /// 获取已加入的群组列表
  Future<ImValueCallback<List<ImGroupInfo>>> getJoinedGroupList() async {
    // TODO: implement getJoinedGroupList
    throw UnimplementedError();
  }

  /// 获取群组信息
  Future<ImValueCallback<List<ImGroupInfoResult>>> getGroupsInfo({
    required List<String> groupIDList,
  }) async {
    // TODO: implement getGroupsInfo
    throw UnimplementedError();
  }

  /// 设置群组信息
  Future<ImCallback> setGroupInfo({required ImGroupInfo info}) async {
    // TODO: implement setGroupInfo
    throw UnimplementedError();
  }

  /// 删除群组属性
  Future<ImCallback> deleteGroupAttributes({
    required String groupID,
    required List<String> keys,
  }) async {
    // TODO: implement deleteGroupAttributes
    throw UnimplementedError();
  }

  /// 获取群组属性
  Future<ImValueCallback<Map<String, String>>> getGroupAttributes({
    required String groupID,
    List<String>? keys,
  }) async {
    // TODO: implement getGroupAttributes
    throw UnimplementedError();
  }

  /// 搜索群组
  Future<ImValueCallback<List<ImGroupInfo>>> searchGroups({
    required ImGroupSearchParam searchParam,
  }) async {
    // TODO: implement searchGroups
    throw UnimplementedError();
  }

  /// 获取群组在线成员数量
  Future<ImValueCallback<int>> getGroupOnlineMemberCount({
    required String groupID,
  }) async {
    // TODO: implement getGroupOnlineMemberCount
    throw UnimplementedError();
  }

  /// 获取群组成员列表
  Future<ImValueCallback<ImGroupMemberInfoResult>> getGroupMemberList({
    required String groupID,
    required GroupMemberFilterTypeEnum filter,
    required String nextSeq,
    int count = 15,
    int offset = 0,
  }) async {
    // TODO: implement getGroupMemberList
    throw UnimplementedError();
  }

  /// 获取群组成员信息
  Future<ImValueCallback<List<ImGroupMemberFullInfo>>> getGroupMembersInfo({
    required String groupID,
    required List<String> memberList,
  }) async {
    // TODO: implement getGroupMembersInfo
    throw UnimplementedError();
  }

  /// 设置群组成员信息
  Future<ImCallback> setGroupMemberInfo({
    required String groupID,
    required String userID,
    String? nameCard,
    Map<String, String>? customInfo,
  }) async {
    // TODO: implement setGroupMemberInfo
    throw UnimplementedError();
  }

  /// 搜索群组成员
  Future<ImValueCallback<GroupMemberInfoSearchResult>> searchGroupMembers({
    required ImGroupMemberSearchParam param,
  }) async {
    // TODO: implement searchGroupMembers
    throw UnimplementedError();
  }

  /// 禁言群组成员
  Future<ImCallback> muteGroupMember({
    required String groupID,
    required String userID,
    required int seconds,
  }) async {
    // TODO: implement muteGroupMember
    throw UnimplementedError();
  }

  /// 踢出群组成员
  Future<ImCallback> kickGroupMember({
    required String groupID,
    required List<String> memberList,
    String? reason,
  }) async {
    // TODO: implement kickGroupMember
    throw UnimplementedError();
  }

  /// 设置群组成员角色
  Future<ImCallback> setGroupMemberRole({
    required String groupID,
    required String userID,
    required GroupMemberRoleTypeEnum role,
  }) async {
    // TODO: implement setGroupMemberRole
    throw UnimplementedError();
  }

  /// 转让群主
  Future<ImCallback> transferGroupOwner({
    required String groupID,
    required String userID,
  }) async {
    // TODO: implement transferGroupOwner
    throw UnimplementedError();
  }

  /// 邀请用户加入群组
  Future<ImValueCallback<List<ImGroupMemberOperationResult>>>
  inviteUserToGroup({
    required String groupID,
    required List<String> userList,
  }) async {
    // TODO: implement inviteUserToGroup
    throw UnimplementedError();
  }

  /// 获取群组申请列表
  Future<ImValueCallback<ImGroupApplicationResult>>
  getGroupApplicationList() async {
    // TODO: implement getGroupApplicationList
    throw UnimplementedError();
  }

  /// 同意群组申请
  Future<ImCallback> acceptGroupApplication({
    required String groupID,
    String? reason,
    required String fromUser,
    required String toUser,
    int? addTime,
    GroupApplicationTypeEnum? type =
        GroupApplicationTypeEnum.IM_GROUP_APPLICATION_GET_TYPE_INVITE,
    String? webMessageInstance,
  }) async {
    // TODO: implement acceptGroupApplication
    throw UnimplementedError();
  }

  /// 拒绝群组申请
  Future<ImCallback> refuseGroupApplication({
    required String groupID,
    String? reason,
    required String fromUser,
    required String toUser,
    required int addTime,
    required GroupApplicationTypeEnum type,
    String? webMessageInstance,
  }) async {
    // TODO: implement refuseGroupApplication
    throw UnimplementedError();
  }

  /// 设置群组申请已读
  Future<ImCallback> setGroupApplicationRead() async {
    // TODO: implement setGroupApplicationRead
    throw UnimplementedError();
  }

  /// 获取已加入的社区列表
  Future<ImValueCallback<List<ImGroupInfo>>> getJoinedCommunityList() async {
    // TODO: implement getJoinedCommunityList
    throw UnimplementedError();
  }

  /// 在社区中创建话题
  Future<ImValueCallback<String>> createTopicInCommunity({
    required String groupID,
    required ImTopicInfo topicInfo,
  }) async {
    // TODO: implement createTopicInCommunity
    throw UnimplementedError();
  }

  /// 从社区中删除话题
  Future<ImValueCallback<List<ImTopicOperationResult>>>
  deleteTopicFromCommunity({
    required String groupID,
    required List<String> topicIDList,
  }) async {
    // TODO: implement deleteTopicFromCommunity
    throw UnimplementedError();
  }

  /// 设置话题信息
  Future<ImCallback> setTopicInfo({
    required String groupID,
    required ImTopicInfo topicInfo,
  }) async {
    // TODO: implement setTopicInfo
    throw UnimplementedError();
  }

  /// 获取话题信息列表
  Future<ImValueCallback<List<ImTopicInfoResult>>> getTopicInfoList({
    required String groupID,
    required List<String> topicIDList,
  }) async {
    // TODO: implement getTopicInfoList
    throw UnimplementedError();
  }
}
