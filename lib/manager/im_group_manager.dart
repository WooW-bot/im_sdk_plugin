import 'package:im_sdk_core/im_sdk_core.dart';
import 'package:im_sdk_core/method_call_handler.dart';
import 'package:im_sdk_plugin/listener/im_group_listener.dart';
import 'package:im_sdk_plugin/mixins/mixin.dart';

import '../enums/group_add_opt_enum.dart';
import '../enums/group_application_type_enum.dart';
import '../enums/group_member_filter_enum.dart';
import '../enums/group_member_role_enum.dart';
import '../im_sdk_plugin.dart';
import '../models/im_group_application_result.dart';
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

/// 群组管理器
class IMGroupManager with BaseMixin {
  final ImSdkCore _imCore;
  ImGroupListener? _groupListener;

  IMGroupManager(this._imCore);

  /// 设置群组监听器
  Future<void> setGroupListener(ImGroupListener? listener) async {
    Logger.debug("[IMGroupManager] 设置群组监听器: ${listener != null ? '已设置' : '已清除'}");
    _groupListener = listener;
  }

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
    // TODO: implement addFriendListener
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

  /// 处理 Group 回调
  void handleGroupCallback(MethodCall call) {
    Logger.debug("[IMGroupManager] 收到群组回调");
    if (_groupListener == null) {
      Logger.warn("[IMGroupManager] 群组监听器未设置");
      return;
    }
    final listener = _groupListener!;

    final Map<String, dynamic> data = formatJson(call.arguments);
    String type = data['type'];
    Logger.debug("[IMGroupManager] 处理群组事件: $type");

    final Map<String, dynamic> params = data['data'] ?? <String, dynamic>{};
    String groupID = params['groupID'] ?? '';
    String opReason = params['opReason'] ?? '';
    bool isAgreeJoin = params['isAgreeJoin'] ?? false;
    String customData = params['customData'] ?? '';
    String topicID = params["topicID"] ?? "";
    List<String> topicIDList = params["topicIDList"] == null
        ? List.empty(growable: true)
        : List.castFrom(params["topicIDList"]);
    ImTopicInfo topicInfo = params["topicInfo"] == null
        ? ImTopicInfo()
        : ImTopicInfo.fromJson(params['topicInfo']);
    Map<String, String> groupAttributeMap = params['groupAttributeMap'] == null
        ? <String, String>{}
        : Map<String, String>.from(params['groupAttributeMap']);
    List<Map<String, dynamic>> memberListMap = params['memberList'] == null
        ? List.empty(growable: true)
        : List.from(params['memberList']);
    List<Map<String, dynamic>> groupMemberChangeInfoListMap =
        params['groupMemberChangeInfoList'] == null
        ? List.empty(growable: true)
        : List.from(params['groupMemberChangeInfoList']);
    List<Map<String, dynamic>> groupChangeInfoListMap =
        params['groupChangeInfoList'] == null
        ? List.empty(growable: true)
        : List.from(params['groupChangeInfoList']);
    List<ImGroupChangeInfo> groupChangeInfoList = List.empty(growable: true);
    List<ImGroupMemberChangeInfo> groupMemberChangeInfoList = List.empty(
      growable: true,
    );
    List<ImGroupMemberInfo> memberList = List.empty(growable: true);
    if (memberListMap.isNotEmpty) {
      for (var element in memberListMap) {
        memberList.add(ImGroupMemberInfo.fromJson(element));
      }
    }
    if (groupMemberChangeInfoListMap.isNotEmpty) {
      for (var element in groupMemberChangeInfoListMap) {
        groupMemberChangeInfoList.add(
          ImGroupMemberChangeInfo.fromJson(element),
        );
      }
    }
    if (groupChangeInfoListMap.isNotEmpty) {
      for (var element in groupChangeInfoListMap) {
        groupChangeInfoList.add(ImGroupChangeInfo.fromJson(element));
      }
    }
    late ImGroupMemberInfo opUser;
    late ImGroupMemberInfo member;
    if (params['opUser'] != null) {
      opUser = ImGroupMemberInfo.fromJson(params['opUser']);
    }
    if (params['member'] != null) {
      member = ImGroupMemberInfo.fromJson(params['member']);
    }

    safeExecute(() {
      switch (type) {
        case 'onMemberEnter':
          listener.onMemberEnter(groupID, memberList);
          break;
        case 'onMemberLeave':
          listener.onMemberLeave(groupID, member);
          break;
        case 'onMemberInvited':
          listener.onMemberInvited(groupID, opUser, memberList);
          break;
        case 'onMemberKicked':
          listener.onMemberKicked(groupID, opUser, memberList);
          break;
        case 'onMemberInfoChanged':
          listener.onMemberInfoChanged(groupID, groupMemberChangeInfoList);
          break;
        case 'onGroupCreated':
          listener.onGroupCreated(groupID);
          break;
        case 'onGroupDismissed':
          listener.onGroupDismissed(groupID, opUser);
          break;
        case 'onGroupRecycled':
          listener.onGroupRecycled(groupID, opUser);
          break;
        case 'onGroupInfoChanged':
          listener.onGroupInfoChanged(groupID, groupChangeInfoList);
          break;
        case 'onReceiveJoinApplication':
          listener.onReceiveJoinApplication(groupID, member, opReason);
          break;
        case 'onApplicationProcessed':
          listener.onApplicationProcessed(
            groupID,
            opUser,
            isAgreeJoin,
            opReason,
          );
          break;
        case 'onGrantAdministrator':
          listener.onGrantAdministrator(groupID, opUser, memberList);
          break;
        case 'onRevokeAdministrator':
          listener.onRevokeAdministrator(groupID, opUser, memberList);
          break;
        case 'onQuitFromGroup':
          listener.onQuitFromGroup(groupID);
          break;
        case 'onReceiveRESTCustomData':
          listener.onReceiveRESTCustomData(groupID, customData);
          break;
        case 'onGroupAttributeChanged':
          listener.onGroupAttributeChanged(groupID, groupAttributeMap);
          break;
        case "onTopicCreated":
          listener.onTopicCreated(groupID, topicID);
          break;
        case "onTopicDeleted":
          listener.onTopicDeleted(groupID, topicIDList);
          break;
        case "onTopicInfoChanged":
          listener.onTopicInfoChanged(groupID, topicInfo);
          break;
        default:
          Logger.warn('未知的 Group 事件类型: $type');
      }
    });
  }
}
