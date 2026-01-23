import '../../im_sdk_plugin.dart';
import '../../models/sync_request.dart';
import '../../models/sync_response.dart';
import 'api_client.dart';

class GroupApi {
  final ApiClient _apiClient;

  GroupApi(this._apiClient);

  // --- Group Basic ---

  /// 导入群组
  Future<ImValueCallback<dynamic>> importGroup(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/importGroup", data: data);
  }

  /// 创建群组
  Future<ImValueCallback<dynamic>> createGroup(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/createGroup", data: data);
  }

  /// 获取群组详细资料
  Future<ImValueCallback<dynamic>> getGroupInfo(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/getGroupInfo", data: data);
  }

  /// 修改群组基础资料
  Future<ImValueCallback<dynamic>> updateGroup(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/update", data: data);
  }

  /// 获取用户所加入的群组
  Future<ImValueCallback<List<ImGroupInfo>>> getJoinedGroupList(
    String userID,
  ) async {
    final req = {'fromId': userID};
    return _apiClient.post<List<ImGroupInfo>>(
      "/v1/group/getJoinedGroup", // Corrected endpoint from "getJoinedGroupList" to "getJoinedGroup" based on controller
      data: req,
    );
  }

  /// 解散群组
  Future<ImValueCallback<dynamic>> destroyGroup(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/destroyGroup", data: data);
  }

  /// 转让群组
  Future<ImValueCallback<dynamic>> transferGroup(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/transferGroup", data: data);
  }

  /// 批量禁言和取消禁言
  Future<ImValueCallback<dynamic>> muteGroup(Map<String, dynamic> data) async {
    return _apiClient.post("/v1/group/forbidSendMessage", data: data);
  }

  /// 在群组中发送普通消息
  Future<ImValueCallback<dynamic>> sendMessage(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/sendMessage", data: data);
  }

  /// 同步已加入的群组
  Future<ImValueCallback<SyncResponse<ImGroupInfo>>> syncJoinedGroup({
    required int lastSequence,
    int maxLimit = 100,
  }) async {
    final req = SyncRequest(lastSequence: lastSequence, maxLimit: maxLimit);
    return _apiClient.post<SyncResponse<ImGroupInfo>>(
      "/v1/group/syncJoinedGroup",
      data: req.toJson(),
    );
  }

  // --- Group Member ---

  /// 导入群成员
  Future<ImValueCallback<dynamic>> importGroupMember(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/member/importGroupMember", data: data);
  }

  /// 增加群成员
  Future<ImValueCallback<dynamic>> addGroupMember(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/member/add", data: data);
  }

  /// 删除群成员
  Future<ImValueCallback<dynamic>> removeGroupMember(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/member/remove", data: data);
  }

  /// 修改群成员资料
  Future<ImValueCallback<dynamic>> updateGroupMember(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/member/update", data: data);
  }

  /// 批量禁言和取消禁言 (成员级别)
  Future<ImValueCallback<dynamic>> muteGroupMember(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/group/member/mute", data: data);
  }
}
