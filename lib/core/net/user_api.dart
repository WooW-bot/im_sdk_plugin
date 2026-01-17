import '../../models/im_value_callback.dart';
import '../../models/im_user_full_info.dart';
import '../../models/req/get_user_info_req.dart';
import 'api_client.dart';

class UserApi {
  final ApiClient _apiClient;

  UserApi(this._apiClient);

  /// 导入用户
  Future<ImValueCallback<dynamic>> importUser(Map<String, dynamic> data) async {
    return _apiClient.post("/v1/user/importUser", data: data);
  }

  /// 删除用户
  Future<ImValueCallback<dynamic>> deleteUser(Map<String, dynamic> data) async {
    return _apiClient.post("/v1/user/deleteUser", data: data);
  }

  /// 获取用户 Sequence
  Future<ImValueCallback<dynamic>> getUserSequence(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/user/getUserSequence", data: data);
  }

  /// 订阅用户在线状态
  Future<ImValueCallback<dynamic>> subscribeUserOnlineStatus(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/user/subscribeUserOnlineStatus", data: data);
  }

  /// 设置用户自定义状态
  Future<ImValueCallback<dynamic>> setUserCustomerStatus(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/user/setUserCustomerStatus", data: data);
  }

  /// 查询好友在线状态
  Future<ImValueCallback<dynamic>> queryFriendOnlineStatus(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/user/queryFriendOnlineStatus", data: data);
  }

  /// 查询用户在线状态
  Future<ImValueCallback<dynamic>> queryUserOnlineStatus(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/user/queryUserOnlineStatus", data: data);
  }

  // --- User Data ---

  /// 获取用户资料
  Future<ImValueCallback<List<ImUserFullInfo>>> getUsersInfo({
    required List<String> userIDs,
  }) async {
    final req = GetUserInfoReq(userIds: userIDs);

    return _apiClient.post<List<ImUserFullInfo>>(
      "/v1/user/data/getUserInfo",
      data: req.toJson(),
    );
  }

  /// 获取单个用户资料
  Future<ImValueCallback<ImUserFullInfo>> getSingleUserInfo(
    String userId,
  ) async {
    return _apiClient.post<ImUserFullInfo>(
      "/v1/user/data/getSingleUserInfo",
      data: {'userId': userId},
    );
  }

  /// 修改用户资料
  Future<ImValueCallback<dynamic>> modifyUserInfo(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/user/data/modifyUserInfo", data: data);
  }
}
