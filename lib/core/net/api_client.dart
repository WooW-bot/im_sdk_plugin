import 'package:dio/dio.dart';
import '../../models/im_value_callback.dart';
import '../../models/im_callback.dart';
import '../../models/sdk_context.dart';

/// IM SDK 网络请求层
class ApiClient {
  final SDKContext _sdkContext;
  final Dio _dio = Dio();

  ApiClient(this._sdkContext);

  /// 发送 POST 请求
  Future<ImValueCallback<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (_sdkContext.appID == null) {
        return ImValueCallback.error(code: -1, msg: "SDK not initialized");
      }

      final String apiHost = _sdkContext.apiHost;
      final Map<String, dynamic> finalQueryParams = {
        'appId': _sdkContext.appID,
        'identifier': _sdkContext.currentUserID,
        'userSign': _sdkContext.userSig,
        ...?queryParameters,
      };

      // 过滤掉 null 值
      finalQueryParams.removeWhere((key, value) => value == null);

      final response = await _dio.post(
        "$apiHost$path",
        data: data,
        queryParameters: finalQueryParams,
      );

      if (response.statusCode == 200 && response.data['code'] == 200) {
        // 使用 generic method 解析
        return ImValueCallback<T>.fromJson(response.data);
      } else {
        return ImValueCallback.error(
          code: response.data['code'] ?? -1,
          msg: response.data['msg'] ?? "Unknown Error",
        );
      }
    } catch (e) {
      return ImValueCallback.error(code: -1, msg: "Request Failed: $e");
    }
  }

  /// 发送 POST 请求 (无返回值)
  Future<ImCallback> postNoResult(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (_sdkContext.appID == null) {
        return ImCallback.error(code: -1, msg: "SDK not initialized");
      }

      final String apiHost = _sdkContext.apiHost;
      final Map<String, dynamic> finalQueryParams = {
        'appId': _sdkContext.appID,
        'identifier': _sdkContext.currentUserID,
        'userSign': _sdkContext.userSig,
        ...?queryParameters,
      };

      finalQueryParams.removeWhere((key, value) => value == null);

      final response = await _dio.post(
        "$apiHost$path",
        data: data,
        queryParameters: finalQueryParams,
      );

      if (response.statusCode == 200 && response.data['code'] == 200) {
        return ImCallback.fromJson(response.data);
      } else {
        return ImCallback.error(
          code: response.data['code'] ?? -1,
          msg: response.data['msg'] ?? "Unknown Error",
        );
      }
    } catch (e) {
      return ImCallback.error(code: -1, msg: "Request Failed: $e");
    }
  }
}
