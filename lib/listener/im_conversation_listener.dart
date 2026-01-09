import '../models/im_conversation.dart';
import 'callbacks.dart';

/// 会话监听器
class ImConversationListener {
  /// 同步服务器开始回调
  VoidCallback onSyncServerStart = () {};

  /// 同步服务器完成回调
  VoidCallback onSyncServerFinish = () {};

  /// 同步服务器失败回调
  VoidCallback onSyncServerFailed = () {};

  /// 收到新会话回调
  OnNewConversation onNewConversation = (List<ImConversation> conversationList) {};

  /// 会话变更回调
  OnConversationChangedCallback onConversationChanged = (List<ImConversation> conversationList) {};

  /// 未读消息计数变更回调
  OnTotalUnreadMessageCountChanged onTotalUnreadMessageCountChanged = (int totalUnreadCount) {};

  /// 会话分组创建回调
  OnConversationGroupCreated onConversationGroupCreated =
      (String groupName, List<ImConversation> conversationList) {};

  /// 会话分组删除回调
  OnConversationGroupDeleted onConversationGroupDeleted = (String groupName) {};

  /// 会话分组名称变更回调
  OnConversationGroupNameChanged onConversationGroupNameChanged =
      (String oldName, String newName) {};

  /// 会话添加到分组回调
  OnConversationsAddedToGroup onConversationsAddedToGroup =
      (String groupName, List<ImConversation> conversationList) {};

  /// 会话从分组删除回调
  OnConversationsDeletedFromGroup onConversationsDeletedFromGroup =
      (String groupName, List<ImConversation> conversationList) {};

  ImConversationListener({
    VoidCallback? onSyncServerStart,
    VoidCallback? onSyncServerFinish,
    VoidCallback? onSyncServerFailed,
    OnNewConversation? onNewConversation,
    OnConversationChangedCallback? onConversationChanged,
    OnTotalUnreadMessageCountChanged? onTotalUnreadMessageCountChanged,
    OnConversationGroupCreated? onConversationGroupCreated,
    OnConversationGroupDeleted? onConversationGroupDeleted,
    OnConversationGroupNameChanged? onConversationGroupNameChanged,
    OnConversationsAddedToGroup? onConversationsAddedToGroup,
    OnConversationsDeletedFromGroup? onConversationsDeletedFromGroup,
  }) {
    if (onSyncServerStart != null) {
      this.onSyncServerStart = onSyncServerStart;
    }
    if (onSyncServerFinish != null) {
      this.onSyncServerFinish = onSyncServerFinish;
    }
    if (onSyncServerFailed != null) {
      this.onSyncServerFailed = onSyncServerFailed;
    }
    if (onNewConversation != null) {
      this.onNewConversation = onNewConversation;
    }
    if (onConversationChanged != null) {
      this.onConversationChanged = onConversationChanged;
    }
    if (onTotalUnreadMessageCountChanged != null) {
      this.onTotalUnreadMessageCountChanged = onTotalUnreadMessageCountChanged;
    }
    if (onConversationGroupCreated != null) {
      this.onConversationGroupCreated = onConversationGroupCreated;
    }
    if (onConversationGroupDeleted != null) {
      this.onConversationGroupDeleted = onConversationGroupDeleted;
    }
    if (onConversationGroupNameChanged != null) {
      this.onConversationGroupNameChanged = onConversationGroupNameChanged;
    }
    if (onConversationsAddedToGroup != null) {
      this.onConversationsAddedToGroup = onConversationsAddedToGroup;
    }
    if (onConversationsDeletedFromGroup != null) {
      this.onConversationsDeletedFromGroup = onConversationsDeletedFromGroup;
    }
  }
}
