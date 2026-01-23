
import 'package:im_sdk_core/core/models/im_value_callback.dart';
import 'package:im_sdk_core/core/models/login_model.dart';

import 'api_client.dart';

class AuthApi {
  final ApiClient _apiClient;

  AuthApi(this._apiClient);

  /// 登录
  Future<ImValueCallback<RouteInfo>> login({
    required String appID,
    required String userID,
    required int clientType,
  }) async {
    final req = LoginReq(appId: appID, userId: userID, clientType: clientType);

    return _apiClient.post<RouteInfo>("/v1/user/login", data: req.toJson());
  }
}
