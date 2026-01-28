import '../im_sdk_plugin.dart';
import 'callbacks.dart';

/// 关系链监听器
class ImFriendshipListener {
  /// 好友申请列表添加回调
  OnFriendApplicationListAddedCallback onFriendApplicationListAdded =
      (List<ImFriendApplication> applicationList) {};

  /// 好友申请列表删除回调
  OnFriendApplicationListDeletedCallback onFriendApplicationListDeleted =
      (List<String> userIDList) {};

  /// 好友申请列表已读回调
  OnFriendApplicationListReadCallback onFriendApplicationListRead = () {};

  /// 好友列表添加回调
  OnFriendListAddedCallback onFriendListAdded = (List<ImFriendInfo> users) {};

  /// 好友列表删除回调
  OnFriendListDeletedCallback onFriendListDeleted = (List<String> userList) {};

  /// 黑名单添加回调
  OnBlackListAddCallback onBlackListAdd = (List<ImFriendInfo> infoList) {};

  /// 黑名单删除回调
  OnBlackListDeletedCallback onBlackListDeleted = (List<String> userList) {};

  /// 好友信息变更回调
  OnFriendInfoChangedCallback onFriendInfoChanged =
      (List<ImFriendInfo> infoList) {};

  ImFriendshipListener({
    OnFriendApplicationListAddedCallback? onFriendApplicationListAdded,
    OnFriendApplicationListDeletedCallback? onFriendApplicationListDeleted,
    OnFriendApplicationListReadCallback? onFriendApplicationListRead,
    OnFriendListAddedCallback? onFriendListAdded,
    OnFriendListDeletedCallback? onFriendListDeleted,
    OnBlackListAddCallback? onBlackListAdd,
    OnBlackListDeletedCallback? onBlackListDeleted,
    OnFriendInfoChangedCallback? onFriendInfoChanged,
  }) {
    if (onFriendApplicationListAdded != null) {
      this.onFriendApplicationListAdded = onFriendApplicationListAdded;
    }
    if (onFriendApplicationListDeleted != null) {
      this.onFriendApplicationListDeleted = onFriendApplicationListDeleted;
    }
    if (onFriendApplicationListRead != null) {
      this.onFriendApplicationListRead = onFriendApplicationListRead;
    }
    if (onFriendListAdded != null) {
      this.onFriendListAdded = onFriendListAdded;
    }
    if (onFriendListDeleted != null) {
      this.onFriendListDeleted = onFriendListDeleted;
    }
    if (onBlackListAdd != null) {
      this.onBlackListAdd = onBlackListAdd;
    }
    if (onBlackListDeleted != null) {
      this.onBlackListDeleted = onBlackListDeleted;
    }
    if (onFriendInfoChanged != null) {
      this.onFriendInfoChanged = onFriendInfoChanged;
    }
  }
}
