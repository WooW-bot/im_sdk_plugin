import '../../im_sdk_plugin.dart';
import '../../models/im_friend_info.dart';
import '../../models/im_friend_check_result.dart';
import '../../models/sync_response.dart';
import '../../models/sync_request.dart';
import '../../models/req/get_friend_list_req.dart';
import '../../enums/friend_type_enum.dart';
import 'api_client.dart';

class FriendshipApi {
  final ApiClient _apiClient;

  FriendshipApi(this._apiClient);

  // --- Friendship Basic ---

  /// 导入好友关系
  Future<ImValueCallback<dynamic>> importFriendShip(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/friendship/importFriendShip", data: data);
  }

  /// 添加好友
  Future<ImValueCallback<dynamic>> addFriend(Map<String, dynamic> data) async {
    return _apiClient.post("/v1/friendship/addFriend", data: data);
  }

  /// 更新好友信息
  Future<ImValueCallback<dynamic>> updateFriend(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/friendship/updateFriend", data: data);
  }

  /// 删除好友
  Future<ImValueCallback<dynamic>> deleteFriend(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/friendship/deleteFriend", data: data);
  }

  /// 删除所有好友
  Future<ImValueCallback<dynamic>> deleteAllFriend(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/friendship/deleteAllFriend", data: data);
  }

  /// 获取好友列表 (Full)
  Future<ImValueCallback<List<ImFriendInfo>>> getFriendList(
    String userID,
  ) async {
    final req = GetFriendListReq(userId: userID);
    return _apiClient.post<List<ImFriendInfo>>(
      "/v1/friendship/getAllFriendShip",
      data: req.toJson(),
    );
  }

  /// 获取好友关系状态
  Future<ImValueCallback<dynamic>> getRelation(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/friendship/getRelation", data: data);
  }

  /// 检查好友关系
  Future<ImValueCallback<List<ImFriendCheckResult>>> checkFriend({
    required String fromUserID,
    required List<String> toUserIDs,
    required FriendTypeEnum checkType,
  }) async {
    int type = checkType == FriendTypeEnum.IM_FRIEND_TYPE_SINGLE ? 1 : 2;
    final req = {'fromId': fromUserID, 'toIds': toUserIDs, 'checkType': type};
    return _apiClient.post<List<ImFriendCheckResult>>(
      "/v1/friendship/checkFriend",
      data: req,
    );
  }

  /// 拉黑用户
  Future<ImValueCallback<dynamic>> addBlack(Map<String, dynamic> data) async {
    return _apiClient.post("/v1/friendship/addBlack", data: data);
  }

  /// 移除黑名单
  Future<ImValueCallback<dynamic>> deleteBlack(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/friendship/deleteBlack", data: data);
  }

  /// 校验黑名单
  Future<ImValueCallback<dynamic>> checkBlack(Map<String, dynamic> data) async {
    return _apiClient.post("/v1/friendship/checkBlack", data: data);
  }

  /// 同步好友列表 (Incremental)
  Future<ImValueCallback<SyncResponse<ImFriendInfo>>> syncFriendList({
    required int lastSequence,
    int maxLimit = 100,
  }) async {
    final req = SyncRequest(lastSequence: lastSequence, maxLimit: maxLimit);
    return _apiClient.post<SyncResponse<ImFriendInfo>>(
      "/v1/friendship/syncFriendshipList",
      data: req.toJson(),
    );
  }

  // --- Friendship Request ---

  /// 审批好友申请
  Future<ImValueCallback<dynamic>> approveFriendRequest(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post(
      "/v1/friendshipRequest/approveFriendRequest",
      data: data,
    );
  }

  /// 获取好友申请
  Future<ImValueCallback<dynamic>> getFriendRequest(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post(
      "/v1/friendshipRequest/getFriendRequest",
      data: data,
    );
  }

  /// 已读好友申请
  Future<ImValueCallback<dynamic>> readFriendShipRequestReq(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post(
      "/v1/friendshipRequest/readFriendShipRequestReq",
      data: data,
    );
  }

  // --- Friendship Group ---

  /// 添加好友分组
  Future<ImValueCallback<dynamic>> addFriendGroup(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/friendship/group/add", data: data);
  }

  /// 删除好友分组
  Future<ImValueCallback<dynamic>> deleteFriendGroup(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/friendship/group/del", data: data);
  }

  /// 添加分组成员
  Future<ImValueCallback<dynamic>> addFriendGroupMember(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/friendship/group/member/add", data: data);
  }

  /// 删除分组成员
  Future<ImValueCallback<dynamic>> deleteFriendGroupMember(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/friendship/group/member/del", data: data);
  }
}
