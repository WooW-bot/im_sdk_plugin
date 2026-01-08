import '../enum/ImFriendshipListener.dart';
import '../enum/friend_application_type_enum.dart';
import '../enum/friend_response_type_enum.dart';
import '../enum/friend_type_enum.dart';
import '../models/im_callback.dart';
import '../models/im_friend_application_result.dart';
import '../models/im_friend_check_result.dart';
import '../models/im_friend_group.dart';
import '../models/im_friend_info.dart';
import '../models/im_friend_info_result.dart';
import '../models/im_friend_operation_result.dart';
import '../models/im_friend_search_param.dart';
import '../models/im_value_callback.dart';

/// 关系链管理器
abstract class IMFriendshipManager {
  /// 添加用户到黑名单
  Future<ImValueCallback<List<ImFriendOperationResult>>> addToBlackList({
    required List<String> userIDList,
  });

  /// 从黑名单移除用户
  Future<ImValueCallback<List<ImFriendOperationResult>>> deleteFromBlackList({
    required List<String> userIDList,
  });

  /// 获取黑名单列表
  Future<ImValueCallback<List<ImFriendInfo>>> getBlackList();

  /// 添加关系链监听器
  Future<void> addFriendListener({required ImFriendshipListener listener});

  /// 移除关系链监听器
  Future<void> removeFriendListener({ImFriendshipListener? listener});

  /// 获取好友列表
  Future<ImValueCallback<List<ImFriendInfo>>> getFriendList();

  /// 获取好友信息
  Future<ImValueCallback<List<ImFriendInfoResult>>> getFriendsInfo({
    required List<String> userIDList,
  });

  /// 设置好友信息
  Future<ImCallback> setFriendInfo({
    required String userID,
    String? friendRemark,
    Map<String, String>? friendCustomInfo,
  });

  /// 添加好友
  Future<ImValueCallback<ImFriendOperationResult>> addFriend({
    required String userID,
    String? remark,
    String? friendGroup,
    String? addWording,
    String? addSource,
    required FriendTypeEnum addType,
  });

  /// 从好友列表删除用户
  Future<ImValueCallback<List<ImFriendOperationResult>>> deleteFromFriendList({
    required List<String> userIDList,
    required FriendTypeEnum deleteType,
  });

  /// 检查好友关系
  Future<ImValueCallback<List<ImFriendCheckResult>>> checkFriend({
    required List<String> userIDList,
    required FriendTypeEnum checkType,
  });

  /// 获取好友申请列表
  Future<ImValueCallback<ImFriendApplicationResult>> getFriendApplicationList();

  /// 同意好友申请
  Future<ImValueCallback<ImFriendOperationResult>> acceptFriendApplication({
    required FriendResponseTypeEnum responseType,
    required FriendApplicationTypeEnum type,
    required String userID,
  });

  /// 拒绝好友申请
  Future<ImValueCallback<ImFriendOperationResult>> refuseFriendApplication({
    required FriendApplicationTypeEnum type,
    required String userID,
  });

  /// 删除好友申请
  Future<ImCallback> deleteFriendApplication({
    required FriendApplicationTypeEnum type,
    required String userID,
  });

  /// 设置好友申请已读
  Future<ImCallback> setFriendApplicationRead();

  /// 创建好友分组
  Future<ImValueCallback<List<ImFriendOperationResult>>> createFriendGroup({
    required String groupName,
    List<String>? userIDList,
  });

  /// 获取好友分组列表
  Future<ImValueCallback<List<ImFriendGroup>>> getFriendGroups({List<String>? groupNameList});

  /// 删除好友分组
  Future<ImCallback> deleteFriendGroup({required List<String> groupNameList});

  /// 重命名好友分组
  Future<ImCallback> renameFriendGroup({required String oldName, required String newName});

  /// 添加好友到分组
  Future<ImValueCallback<List<ImFriendOperationResult>>> addFriendsToFriendGroup({
    required String groupName,
    required List<String> userIDList,
  });

  /// 从分组中删除好友
  Future<ImValueCallback<List<ImFriendOperationResult>>> deleteFriendsFromFriendGroup({
    required String groupName,
    required List<String> userIDList,
  });

  /// 搜索好友
  Future<ImValueCallback<List<ImFriendInfoResult>>> searchFriends({
    required ImFriendSearchParam searchParam,
  });
}
