import '../models/im_group_change_info.dart';
import '../models/im_group_member_change_info.dart';
import '../models/im_group_member_info.dart';
import '../models/im_topic_info.dart';
import 'callbacks.dart';

class ImGroupListener {
  /// 成员进入群组回调
  OnMemberEnterCallback onMemberEnter = (String groupID, List<ImGroupMemberInfo> memberList) {};

  /// 成员离开群组回调
  OnMemberLeaveCallback onMemberLeave = (String groupID, ImGroupMemberInfo member) {};

  /// 成员被邀请回调
  OnMemberInvitedCallback onMemberInvited =
      (String groupID, ImGroupMemberInfo opUser, List<ImGroupMemberInfo> memberList) {};

  /// 成员被踢出回调
  OnMemberKickedCallback onMemberKicked =
      (String groupID, ImGroupMemberInfo opUser, List<ImGroupMemberInfo> memberList) {};

  /// 成员信息变更回调
  OnMemberInfoChangedCallback onMemberInfoChanged =
      (String groupID, List<ImGroupMemberChangeInfo> IMGroupMemberChangeInfoList) {};

  /// 群组创建回调
  OnGroupCreatedCallback onGroupCreated = (String groupID) {};

  /// 群组解散回调
  OnGroupDismissedCallback onGroupDismissed = (String groupID, ImGroupMemberInfo opUser) {};

  /// 群组回收回调
  OnGroupRecycledCallback onGroupRecycled = (String groupID, ImGroupMemberInfo opUser) {};

  /// 群组信息变更回调
  OnGroupInfoChangedCallback onGroupInfoChanged =
      (String groupID, List<ImGroupChangeInfo?> changeInfos) {};

  /// 收到入群申请回调
  OnReceiveJoinApplicationCallback onReceiveJoinApplication =
      (String groupID, ImGroupMemberInfo member, String opReason) {};

  /// 申请处理完成回调
  OnApplicationProcessedCallback onApplicationProcessed =
      (String groupID, ImGroupMemberInfo opUser, bool isAgreeJoin, String opReason) {};

  /// 授予管理员身份回调
  OnGrantAdministratorCallback onGrantAdministrator =
      (String groupID, ImGroupMemberInfo opUser, List<ImGroupMemberInfo> memberList) {};

  /// 撤销管理员身份回调
  OnRevokeAdministratorCallback onRevokeAdministrator =
      (String groupID, ImGroupMemberInfo opUser, List<ImGroupMemberInfo> memberList) {};

  /// 退出群组回调
  OnQuitFromGroupCallback onQuitFromGroup = (String groupID) {};

  /// 收到 REST 自定义数据回调
  OnReceiveRESTCustomDataCallback onReceiveRESTCustomData = (String groupID, String customData) {};

  /// 群组属性变更回调
  OnGroupAttributeChangedCallback onGroupAttributeChanged =
      (String groupID, Map<String, String> groupAttributeMap) {};

  /// 话题创建回调
  OnTopicCreated onTopicCreated = (String groupID, String topicID) {};

  /// 话题删除回调
  OnTopicDeleted onTopicDeleted = (String groupID, List<String> topicIDList) {};

  /// 话题信息变更回调
  OnTopicInfoChanged onTopicInfoChanged = (String groupID, ImTopicInfo topicInfo) {};

  ImGroupListener({
    OnApplicationProcessedCallback? onApplicationProcessed,
    OnGrantAdministratorCallback? onGrantAdministrator,
    OnGroupAttributeChangedCallback? onGroupAttributeChanged,
    OnGroupCreatedCallback? onGroupCreated,
    OnGroupDismissedCallback? onGroupDismissed,
    OnGroupInfoChangedCallback? onGroupInfoChanged,
    OnGroupRecycledCallback? onGroupRecycled,
    OnMemberEnterCallback? onMemberEnter,
    OnMemberInfoChangedCallback? onMemberInfoChanged,
    OnMemberInvitedCallback? onMemberInvited,
    OnMemberKickedCallback? onMemberKicked,
    OnMemberLeaveCallback? onMemberLeave,
    OnQuitFromGroupCallback? onQuitFromGroup,
    OnReceiveJoinApplicationCallback? onReceiveJoinApplication,
    OnReceiveRESTCustomDataCallback? onReceiveRESTCustomData,
    OnRevokeAdministratorCallback? onRevokeAdministrator,
    OnTopicCreated? onTopicCreated,
    OnTopicDeleted? onTopicDeleted,
    OnTopicInfoChanged? onTopicInfoChanged,
  }) {
    if (onApplicationProcessed != null) {
      this.onApplicationProcessed = onApplicationProcessed;
    }
    if (onGrantAdministrator != null) {
      this.onGrantAdministrator = onGrantAdministrator;
    }
    if (onGroupAttributeChanged != null) {
      this.onGroupAttributeChanged = onGroupAttributeChanged;
    }
    if (onGroupCreated != null) {
      this.onGroupCreated = onGroupCreated;
    }
    if (onGroupDismissed != null) {
      this.onGroupDismissed = onGroupDismissed;
    }
    if (onGroupInfoChanged != null) {
      this.onGroupInfoChanged = onGroupInfoChanged;
    }
    if (onGroupRecycled != null) {
      this.onGroupRecycled = onGroupRecycled;
    }
    if (onMemberEnter != null) {
      this.onMemberEnter = onMemberEnter;
    }
    if (onMemberInfoChanged != null) {
      this.onMemberInfoChanged = onMemberInfoChanged;
    }
    if (onMemberInvited != null) {
      this.onMemberInvited = onMemberInvited;
    }
    if (onMemberKicked != null) {
      this.onMemberKicked = onMemberKicked;
    }
    if (onMemberLeave != null) {
      this.onMemberLeave = onMemberLeave;
    }
    if (onQuitFromGroup != null) {
      this.onQuitFromGroup = onQuitFromGroup;
    }
    if (onReceiveRESTCustomData != null) {
      this.onReceiveRESTCustomData = onReceiveRESTCustomData;
    }
    if (onReceiveJoinApplication != null) {
      this.onReceiveJoinApplication = onReceiveJoinApplication;
    }
    if (onRevokeAdministrator != null) {
      this.onRevokeAdministrator = onRevokeAdministrator;
    }
    if (onTopicCreated != null) {
      this.onTopicCreated = onTopicCreated;
    }
    if (onTopicDeleted != null) {
      this.onTopicDeleted = onTopicDeleted;
    }
    if (onTopicInfoChanged != null) {
      this.onTopicInfoChanged = onTopicInfoChanged;
    }
  }
}
