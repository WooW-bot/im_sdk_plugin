import '../models/sdk_context.dart';
import '../listener/im_friendship_listener.dart';
import '../enums/friend_application_type_enum.dart';
import '../enums/friend_response_type_enum.dart';
import '../enums/friend_type_enum.dart';
import '../models/im_callback.dart';
import '../models/im_friend_application_result.dart';
import '../models/im_friend_check_result.dart';
import '../models/im_friend_group.dart';
import '../models/im_friend_info.dart';
import '../models/im_friend_info_result.dart';
import '../models/im_friend_operation_result.dart';
import '../models/im_friend_search_param.dart';
import '../models/im_value_callback.dart';
import '../core/im_core.dart';
import '../models/req/get_friend_list_req.dart';
import '../db/db_manager.dart';
import '../models/sync_request.dart';
import '../models/sync_response.dart';

/// 关系链管理器
class IMFriendshipManager {
  final SDKContext _sdkContext;
  final ImCore _imCore;

  IMFriendshipManager(this._sdkContext, this._imCore);

  /// 添加用户到黑名单
  Future<ImValueCallback<List<ImFriendOperationResult>>> addToBlackList({
    required List<String> userIDList,
  }) async {
    // TODO: implement addToBlackList
    throw UnimplementedError();
  }

  /// 从黑名单移除用户
  Future<ImValueCallback<List<ImFriendOperationResult>>> deleteFromBlackList({
    required List<String> userIDList,
  }) async {
    // TODO: implement deleteFromBlackList
    throw UnimplementedError();
  }

  /// 获取黑名单列表
  Future<ImValueCallback<List<ImFriendInfo>>> getBlackList() async {
    try {
      final list = await DBManager().getBlackList();
      return ImValueCallback.success(data: list);
    } catch (e) {
      return ImValueCallback.error(msg: "getBlackList Failed: $e", data: []);
    }
  }

  /// 添加关系链监听器
  Future<void> addFriendListener({
    required ImFriendshipListener listener,
  }) async {
    // TODO: implement addFriendListener
    throw UnimplementedError();
  }

  /// 移除关系链监听器
  Future<void> removeFriendListener({ImFriendshipListener? listener}) async {
    // TODO: implement removeFriendListener
    throw UnimplementedError();
  }

  // ...

  /// 获取好友列表
  Future<ImValueCallback<List<ImFriendInfo>>> getFriendList() async {
    try {
      if (_sdkContext.appID == null ||
          _sdkContext.currentUserID == null ||
          _sdkContext.userSig == null) {
        return ImValueCallback.error(
          msg: "SDK not initialized or not logged in",
          data: [],
        );
      }

      final req = GetFriendListReq(userId: _sdkContext.currentUserID!);

      final result = await _imCore.post<List<ImFriendInfo>>(
        "/v1/friendship/getAllFriendShip",
        data: req.toJson(),
      );

      // 数据同步：持久化到本地数据库
      if (result.isSuccess && result.data != null) {
        await DBManager().batchInsertFriends(result.data!);
      }

      return result;
    } catch (e) {
      return ImValueCallback.error(msg: "getFriendList Failed: $e", data: []);
    }
  }

  /// 增量同步好友列表
  Future<ImValueCallback<List<ImFriendInfo>>> syncFriendList() async {
    try {
      if (_sdkContext.appID == null ||
          _sdkContext.currentUserID == null ||
          _sdkContext.userSig == null) {
        return ImValueCallback.error(
          msg: "SDK not initialized or not logged in",
          data: [],
        );
      }

      int lastSeq = await DBManager().getFriendMaxSequence();
      bool completed = false;
      List<ImFriendInfo> allSyncedFriends = [];

      while (!completed) {
        final req = SyncRequest(
          lastSequence: lastSeq,
          maxLimit: 100, // Reasonable batch size
        );

        final ImValueCallback<SyncResponse<ImFriendInfo>> result = await _imCore
            .post<SyncResponse<ImFriendInfo>>(
              "/v1/friendship/syncFriendshipList",
              data: req.toJson(),
            );

        if (!result.isSuccess || result.data == null) {
          return ImValueCallback.error(
            code: result.code,
            msg: result.msg,
            data: allSyncedFriends,
          );
        }

        final syncResp = result.data!;
        final list = syncResp.dataList ?? [];

        if (list.isNotEmpty) {
          // 批量插入/更新数据库
          await DBManager().batchInsertFriends(list);
          allSyncedFriends.addAll(list);
          // Update lastSeq for next page based on response maxSequence
          if (syncResp.maxSequence != null) {
            lastSeq = syncResp.maxSequence!;
          } else {
            // Fallback if maxSequence missing, check last item
            lastSeq = list.last.friendSequence ?? lastSeq;
          }
        }

        completed = syncResp.completed ?? true;
      }

      return ImValueCallback.success(data: allSyncedFriends);
    } catch (e) {
      return ImValueCallback.error(msg: "syncFriendList Failed: $e", data: []);
    }
  }

  /// 获取好友信息
  Future<ImValueCallback<List<ImFriendInfoResult>>> getFriendsInfo({
    required List<String> userIDList,
  }) async {
    // TODO: implement getFriendsInfo
    throw UnimplementedError();
  }

  /// 设置好友信息
  Future<ImCallback> setFriendInfo({
    required String userID,
    String? friendRemark,
    Map<String, String>? friendCustomInfo,
  }) async {
    // TODO: implement setFriendInfo
    throw UnimplementedError();
  }

  /// 添加好友
  Future<ImValueCallback<ImFriendOperationResult>> addFriend({
    required String userID,
    String? remark,
    String? friendGroup,
    String? addWording,
    String? addSource,
    required FriendTypeEnum addType,
  }) async {
    // TODO: implement addFriend
    throw UnimplementedError();
  }

  /// 从好友列表删除用户
  Future<ImValueCallback<List<ImFriendOperationResult>>> deleteFromFriendList({
    required List<String> userIDList,
    required FriendTypeEnum deleteType,
  }) async {
    // TODO: implement deleteFromFriendList
    throw UnimplementedError();
  }

  /// 检查好友关系
  Future<ImValueCallback<List<ImFriendCheckResult>>> checkFriend({
    required List<String> userIDList,
    required FriendTypeEnum checkType,
  }) async {
    // TODO: implement checkFriend
    throw UnimplementedError();
  }

  /// 获取好友申请列表
  Future<ImValueCallback<ImFriendApplicationResult>>
  getFriendApplicationList() async {
    // TODO: implement getFriendApplicationList
    throw UnimplementedError();
  }

  /// 同意好友申请
  Future<ImValueCallback<ImFriendOperationResult>> acceptFriendApplication({
    required FriendResponseTypeEnum responseType,
    required FriendApplicationTypeEnum type,
    required String userID,
  }) async {
    // TODO: implement acceptFriendApplication
    throw UnimplementedError();
  }

  /// 拒绝好友申请
  Future<ImValueCallback<ImFriendOperationResult>> refuseFriendApplication({
    required FriendApplicationTypeEnum type,
    required String userID,
  }) async {
    // TODO: implement refuseFriendApplication
    throw UnimplementedError();
  }

  /// 删除好友申请
  Future<ImCallback> deleteFriendApplication({
    required FriendApplicationTypeEnum type,
    required String userID,
  }) async {
    // TODO: implement deleteFriendApplication
    throw UnimplementedError();
  }

  /// 设置好友申请已读
  Future<ImCallback> setFriendApplicationRead() async {
    // TODO: implement setFriendApplicationRead
    throw UnimplementedError();
  }

  /// 创建好友分组
  Future<ImValueCallback<List<ImFriendOperationResult>>> createFriendGroup({
    required String groupName,
    List<String>? userIDList,
  }) async {
    // TODO: implement createFriendGroup
    throw UnimplementedError();
  }

  /// 获取好友分组列表
  Future<ImValueCallback<List<ImFriendGroup>>> getFriendGroups({
    List<String>? groupNameList,
  }) async {
    // TODO: implement getFriendGroups
    throw UnimplementedError();
  }

  /// 删除好友分组
  Future<ImCallback> deleteFriendGroup({
    required List<String> groupNameList,
  }) async {
    // TODO: implement deleteFriendGroup
    throw UnimplementedError();
  }

  /// 重命名好友分组
  Future<ImCallback> renameFriendGroup({
    required String oldName,
    required String newName,
  }) async {
    // TODO: implement renameFriendGroup
    throw UnimplementedError();
  }

  /// 添加好友到分组
  Future<ImValueCallback<List<ImFriendOperationResult>>>
  addFriendsToFriendGroup({
    required String groupName,
    required List<String> userIDList,
  }) async {
    // TODO: implement addFriendsToFriendGroup
    throw UnimplementedError();
  }

  /// 从分组中删除好友
  Future<ImValueCallback<List<ImFriendOperationResult>>>
  deleteFriendsFromFriendGroup({
    required String groupName,
    required List<String> userIDList,
  }) async {
    // TODO: implement deleteFriendsFromFriendGroup
    throw UnimplementedError();
  }

  /// 搜索好友
  Future<ImValueCallback<List<ImFriendInfoResult>>> searchFriends({
    required ImFriendSearchParam searchParam,
  }) async {
    // TODO: implement searchFriends
    throw UnimplementedError();
  }
}
