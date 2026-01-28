import 'package:im_sdk_core/im_sdk_core.dart';
import 'package:im_sdk_plugin/mixins/mixin.dart';

import '../im_sdk_plugin.dart';
import '../listener/im_friendship_listener.dart';

/// 关系链管理器
class IMFriendshipManager with BaseMixin {
  final ImSdkCore _imCore;
  ImFriendshipListener? _friendListener;

  IMFriendshipManager(this._imCore);

  /// 设置关系链监听器
  Future<void> setFriendListener(ImFriendshipListener? listener) async {
    Logger.debug(
      "[IMFriendshipManager] 设置好友监听器: ${listener != null ? '已设置' : '已清除'}",
    );
    _friendListener = listener;
  }

  /// 添加用户到黑名单
  Future<ImValueCallback<List<ImFriendOperationResult>>> addToBlackList({
    required List<String> userIDList,
  }) async {
    return _imCore.addToBlackList(userIDList: userIDList);
  }

  /// 从黑名单移除用户
  Future<ImValueCallback<List<ImFriendOperationResult>>> deleteFromBlackList({
    required List<String> userIDList,
  }) async {
    return _imCore.deleteFromBlackList(userIDList: userIDList);
  }

  /// 获取黑名单列表
  Future<ImValueCallback<List<ImFriendInfo>>> getBlackList() async {
    return _imCore.getBlackList();
  }

  /// 获取好友列表
  Future<ImValueCallback<List<ImFriendInfo>>> getFriendList() async {
    return _imCore.getFriendList();
  }

  /// 获取指定好友信息 (Smart Fetch: Local -> Network)
  Future<ImValueCallback<List<ImFriendInfoResult>>> getFriendsInfo({
    required List<String> userIDList,
  }) async {
    return _imCore.getFriendsInfo(userIDList: userIDList);
  }

  /// 设置好友信息
  Future<ImCallback> setFriendInfo({
    required String userID,
    String? friendRemark,
    Map<String, String>? friendCustomInfo,
  }) async {
    return _imCore.setFriendInfo(
      userID: userID,
      friendRemark: friendRemark,
      friendCustomInfo: friendCustomInfo,
    );
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
    return _imCore.addFriend(
      userID: userID,
      remark: remark,
      friendGroup: friendGroup,
      addWording: addWording,
      addSource: addSource,
      addType: addType,
    );
  }

  /// 从好友列表删除用户
  Future<ImValueCallback<List<ImFriendOperationResult>>> deleteFromFriendList({
    required List<String> userIDList,
    required FriendTypeEnum deleteType,
  }) async {
    return _imCore.deleteFromFriendList(
      userIDList: userIDList,
      deleteType: deleteType,
    );
  }

  /// 检查好友关系
  Future<ImValueCallback<List<ImFriendCheckResult>>> checkFriend({
    required List<String> userIDList,
    required FriendTypeEnum checkType,
  }) async {
    return _imCore.checkFriend(userIDList: userIDList, checkType: checkType);
  }

  /// 获取好友申请列表
  Future<ImValueCallback<ImFriendApplicationResult>>
  getFriendApplicationList() async {
    return _imCore.getFriendApplicationList();
  }

  /// 同意好友申请
  Future<ImValueCallback<ImFriendOperationResult>> acceptFriendApplication({
    required FriendResponseTypeEnum responseType,
    required FriendApplicationTypeEnum type,
    required String userID,
  }) async {
    return _imCore.acceptFriendApplication(
      responseType: responseType,
      type: type,
      userID: userID,
    );
  }

  /// 拒绝好友申请
  Future<ImValueCallback<ImFriendOperationResult>> refuseFriendApplication({
    required FriendApplicationTypeEnum type,
    required String userID,
  }) async {
    return _imCore.refuseFriendApplication(type: type, userID: userID);
  }

  /// 删除好友申请
  Future<ImCallback> deleteFriendApplication({
    required FriendApplicationTypeEnum type,
    required String userID,
  }) async {
    return _imCore.deleteFriendApplication(type: type, userID: userID);
  }

  /// 设置好友申请已读
  Future<ImCallback> setFriendApplicationRead() async {
    return _imCore.setFriendApplicationRead();
  }

  /// 创建好友分组
  Future<ImValueCallback<List<ImFriendOperationResult>>> createFriendGroup({
    required String groupName,
    List<String>? userIDList,
  }) async {
    return _imCore.createFriendGroup(
      groupName: groupName,
      userIDList: userIDList,
    );
  }

  /// 获取好友分组列表
  Future<ImValueCallback<List<ImFriendGroup>>> getFriendGroups({
    List<String>? groupNameList,
  }) async {
    return _imCore.getFriendGroups(groupNameList: groupNameList);
  }

  /// 删除好友分组
  Future<ImCallback> deleteFriendGroup({
    required List<String> groupNameList,
  }) async {
    return _imCore.deleteFriendGroup(groupNameList: groupNameList);
  }

  /// 重命名好友分组
  Future<ImCallback> renameFriendGroup({
    required String oldName,
    required String newName,
  }) async {
    return _imCore.renameFriendGroup(oldName: oldName, newName: newName);
  }

  /// 添加好友到分组
  Future<ImValueCallback<List<ImFriendOperationResult>>>
  addFriendsToFriendGroup({
    required String groupName,
    required List<String> userIDList,
  }) async {
    return _imCore.addFriendsToFriendGroup(
      groupName: groupName,
      userIDList: userIDList,
    );
  }

  /// 从分组中删除好友
  Future<ImValueCallback<List<ImFriendOperationResult>>>
  deleteFriendsFromFriendGroup({
    required String groupName,
    required List<String> userIDList,
  }) async {
    return _imCore.deleteFriendsFromFriendGroup(
      groupName: groupName,
      userIDList: userIDList,
    );
  }

  /// 搜索好友
  Future<ImValueCallback<List<ImFriendInfoResult>>> searchFriends({
    required ImFriendSearchParam searchParam,
  }) async {
    return _imCore.searchFriends(searchParam: searchParam);
  }

  void handleFriendCallback(MethodCall call) {
    Logger.debug("[IMFriendshipManager] 收到好友回调");
    if (_friendListener == null) {
      Logger.warn("[IMFriendshipManager] 好友监听器未设置");
      return;
    }
    final listener = _friendListener!;

    Map<String, dynamic> data = formatJson(call.arguments);
    String type = data['type'];
    Logger.debug("[IMFriendshipManager] 处理好友事件: $type");

    dynamic params = data['data'] ?? <String, dynamic>{};

    safeExecute(() {
      switch (type) {
        case 'onFriendApplicationListAdded':
          List applicationListMap = params;
          List<ImFriendApplication> applicationList = List.empty(
            growable: true,
          );
          for (var element in applicationListMap) {
            applicationList.add(ImFriendApplication.fromJson(element));
          }
          listener.onFriendApplicationListAdded(applicationList);
          break;
        case 'onFriendApplicationListDeleted':
          List<String> userIDList = List.from(params);
          listener.onFriendApplicationListDeleted(userIDList);
          break;
        case 'onFriendApplicationListRead':
          listener.onFriendApplicationListRead();
          break;
        case 'onFriendListAdded':
          List userMap = params;
          List<ImFriendInfo> users = List.empty(growable: true);
          for (var element in userMap) {
            users.add(ImFriendInfo.fromJson(element));
          }
          listener.onFriendListAdded(users);
          break;
        case 'onFriendListDeleted':
          List<String> userList = List.from(params);
          listener.onFriendListDeleted(userList);
          break;
        case 'onBlackListAdd':
          List infoListMap = params;
          List<ImFriendInfo> infoList = List.empty(growable: true);
          for (var element in infoListMap) {
            infoList.add(ImFriendInfo.fromJson(element));
          }
          listener.onBlackListAdd(infoList);
          break;
        case 'onBlackListDeleted':
          List<String> userList = List.from(params);
          listener.onBlackListDeleted(userList);
          break;
        case 'onFriendInfoChanged':
          List infoListMap = params;
          List<ImFriendInfo> infoList = List.empty(growable: true);
          for (var element in infoListMap) {
            infoList.add(ImFriendInfo.fromJson(element));
          }
          listener.onFriendInfoChanged(infoList);
          break;
      }
    });
  }
}
