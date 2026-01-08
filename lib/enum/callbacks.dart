import '../models/im_conversation.dart';
import '../models/im_friend_application.dart';
import '../models/im_friend_info.dart';
import '../models/im_group_change_info.dart';
import '../models/im_group_member_change_info.dart';
import '../models/im_group_member_info.dart';
import '../models/im_message.dart';
import '../models/im_message_download_progress.dart';
import '../models/im_message_extension.dart';
import '../models/im_message_receipt.dart';
import '../models/im_topic_info.dart';
import '../models/im_user_full_info.dart';
import '../models/im_user_info.dart';
import '../models/im_user_status.dart';

/// 空参数回调
typedef VoidCallback = void Function();

/// 错误回调
///
/// [code] 错误码
/// [error] 错误描述
typedef ErrorCallback = void Function(int code, String error);

/// 用户全量信息回调
typedef ImUserFullInfoCallback = void Function(ImUserFullInfo info);

/// 未读消息总数变更回调
typedef OnTotalUnreadMessageCountChanged = void Function(int totalUnreadCount);

/// 用户状态变更回调
typedef OnUserStatusChanged = void Function(List<ImUserStatus> userStatusList);

/// 日志回调
typedef OnLog = void Function(int logLevel, String logContent);

/// 收到 C2C 文本消息回调
typedef OnRecvC2CTextMessageCallback =
    void Function(String msgID, ImUserInfo userInfo, String text);

/// 收到消息扩展变更回调
typedef OnRecvMessageExtensionsChanged =
    void Function(String msgID, List<ImMessageExtension> extensions);

/// 收到消息扩展删除回调
typedef OnRecvMessageExtensionsDeleted =
    void Function(String msgID, List<String> extensionKeys);

/// 消息下载进度回调
typedef OnMessageDownloadProgressCallback =
    void Function(ImMessageDownloadProgress messageProgress);

/// 收到 C2C 自定义消息回调
typedef OnRecvC2CCustomMessageCallback =
    void Function(String msgID, ImUserInfo sender, String customData);

/// 收到群文本消息回调
typedef OnRecvGroupTextMessageCallback =
    void Function(
      String msgID,
      String groupID,
      ImGroupMemberInfo sender,
      String text,
    );

/// 收到群自定义消息回调
typedef OnRecvGroupCustomMessageCallback =
    void Function(
      String msgID,
      String groupID,
      ImGroupMemberInfo sender,
      String customData,
    );

/// 群成员进入回调
typedef OnMemberEnterCallback =
    void Function(String groupID, List<ImGroupMemberInfo> memberList);

/// 群成员离开回调
typedef OnMemberLeaveCallback =
    void Function(String groupID, ImGroupMemberInfo member);

/// 群成员被邀请回调
typedef OnMemberInvitedCallback =
    void Function(
      String groupID,
      ImGroupMemberInfo opUser,
      List<ImGroupMemberInfo> memberList,
    );

/// 群成员被踢回调
typedef OnMemberKickedCallback =
    void Function(
      String groupID,
      ImGroupMemberInfo opUser,
      List<ImGroupMemberInfo> memberList,
    );

/// 群成员信息变更回调
typedef OnMemberInfoChangedCallback =
    void Function(
      String groupID,
      List<ImGroupMemberChangeInfo> v2TIMGroupMemberChangeInfoList,
    );

/// 群创建回调
typedef OnGroupCreatedCallback = void Function(String groupID);

/// 群解散回调
typedef OnGroupDismissedCallback =
    void Function(String groupID, ImGroupMemberInfo opUser);

/// 群回收回调
typedef OnGroupRecycledCallback =
    void Function(String groupID, ImGroupMemberInfo opUser);

/// 群信息变更回调
typedef OnGroupInfoChangedCallback =
    void Function(String groupID, List<ImGroupChangeInfo> changeInfos);

/// 收到入群申请回调
typedef OnReceiveJoinApplicationCallback =
    void Function(String groupID, ImGroupMemberInfo member, String opReason);

/// 入群申请被处理回调
typedef OnApplicationProcessedCallback =
    void Function(
      String groupID,
      ImGroupMemberInfo opUser,
      bool isAgreeJoin,
      String opReason,
    );

/// 授予管理员身份回调
typedef OnGrantAdministratorCallback =
    void Function(
      String groupID,
      ImGroupMemberInfo opUser,
      List<ImGroupMemberInfo> memberList,
    );

/// 撤销管理员身份回调
typedef OnRevokeAdministratorCallback =
    void Function(
      String groupID,
      ImGroupMemberInfo opUser,
      List<ImGroupMemberInfo> memberList,
    );

/// 退出群组回调
typedef OnQuitFromGroupCallback = void Function(String groupID);

/// 收到 REST 自定义数据回调
typedef OnReceiveRESTCustomDataCallback =
    void Function(String groupID, String customData);

/// 群属性变更回调
typedef OnGroupAttributeChangedCallback =
    void Function(String groupID, Map<String, String> groupAttributeMap);

/// 收到新消息回调
typedef OnRecvNewMessageCallback = void Function(ImMessage msg);

/// 消息被修改回调
typedef OnRecvMessageModified = void Function(ImMessage msg);

/// 收到 C2C 消息已读回执回调
typedef OnRecvC2CReadReceiptCallback =
    void Function(List<ImMessageReceipt> receiptList);

/// 收到消息撤回回调
typedef OnRecvMessageRevokedCallback = void Function(String msgID);

/// 好友申请列表添加回调
typedef OnFriendApplicationListAddedCallback =
    void Function(List<ImFriendApplication> applicationList);

/// 好友申请列表删除回调
typedef OnFriendApplicationListDeletedCallback =
    void Function(List<String> userIDList);

/// 好友申请列表已读回调
typedef OnFriendApplicationListReadCallback = void Function();

/// 好友列表添加回调
typedef OnFriendListAddedCallback = void Function(List<ImFriendInfo> users);

/// 好友列表删除回调
typedef OnFriendListDeletedCallback = void Function(List<String> userList);

/// 黑名单添加回调
typedef OnBlackListAddCallback = void Function(List<ImFriendInfo> infoList);

/// 黑名单删除回调
typedef OnBlackListDeletedCallback = void Function(List<String> userList);

/// 好友信息变更回调
typedef OnFriendInfoChangedCallback =
    void Function(List<ImFriendInfo> infoList);

/// 会话变更回调
typedef OnConversationChangedCallback =
    void Function(List<ImConversation> conversationList);

/// 新会话回调
typedef OnNewConversation =
    void Function(List<ImConversation> conversationList);

/// 收到新邀请回调
typedef OnReceiveNewInvitationCallback =
    void Function(
      String inviteID,
      String inviter,
      String groupID,
      List<String> inviteeList,
      String data,
    );

/// 邀请被接受回调
typedef OnInviteeAcceptedCallback =
    void Function(String inviteID, String invitee, String data);

/// 邀请被拒绝回调
typedef OnInviteeRejectedCallback =
    void Function(String inviteID, String invitee, String data);

/// 邀请被取消回调
typedef OnInvitationCancelledCallback =
    void Function(String inviteID, String inviter, String data);

/// 邀请超时回调
typedef OnInvitationTimeoutCallback =
    void Function(String inviteID, List<String> inviteeList);

/// 发送消息进度回调
typedef OnSendMessageProgressCallback =
    void Function(ImMessage message, int progress);

/// 收到消息已读回执（包含群）回调
typedef OnRecvMessageReadReceipts =
    void Function(List<ImMessageReceipt> receiptList);

/// 会话分组创建回调
typedef OnConversationGroupCreated =
    void Function(String groupName, List<ImConversation> conversationList);

/// 会话分组删除回调
typedef OnConversationGroupDeleted = void Function(String groupName);

/// 会话分组名称变更回调
typedef OnConversationGroupNameChanged =
    void Function(String oldName, String newName);

/// 会话分组添加会话回调
typedef OnConversationsAddedToGroup =
    void Function(String groupName, List<ImConversation> conversationList);

/// 会话分组删除会话回调
typedef OnConversationsDeletedFromGroup =
    void Function(String groupName, List<ImConversation> conversationList);

/// 话题创建回调
typedef OnTopicCreated = void Function(String groupID, String topicID);

/// 话题删除回调
typedef OnTopicDeleted =
    void Function(String groupID, List<String> topicIDList);

/// 话题信息变更回调
typedef OnTopicInfoChanged =
    void Function(String groupID, ImTopicInfo topicInfo);
