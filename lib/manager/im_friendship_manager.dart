import 'package:im_sdk_core/im_sdk_core.dart';
import 'package:im_sdk_plugin/mixins/mixin.dart';
import 'package:im_sdk_plugin/models/im_friend_application.dart';

import '../im_sdk_plugin.dart';
import '../listener/im_friendship_listener.dart';
import '../enums/friend_application_type_enum.dart';
import '../enums/friend_response_type_enum.dart';
import '../models/im_friend_application_result.dart';
import '../models/im_friend_group.dart';

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
    return _imCore.checkFriend(userIDList: userIDList, checkType: checkType);
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
