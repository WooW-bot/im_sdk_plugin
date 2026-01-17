import '../../models/im_value_callback.dart';
import '../../models/im_message.dart';
import '../../models/sync_request.dart';
import 'api_client.dart';

class MessageApi {
  final ApiClient _apiClient;

  MessageApi(this._apiClient);

  /// 发送消息 (P2P)
  Future<ImValueCallback<dynamic>> send(Map<String, dynamic> data) async {
    return _apiClient.post("/v1/message/send", data: data);
  }

  /// 检查 P2P 发送权限
  Future<ImValueCallback<dynamic>> p2pCheckSend(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/message/p2pCheckSend", data: data);
  }

  /// 检查 Group 发送权限
  Future<ImValueCallback<dynamic>> groupCheckSend(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/message/groupCheckSend", data: data);
  }

  /// 同步离线消息
  Future<ImValueCallback<List<ImMessage>>> syncOfflineMessages({
    required String userID,
    required int startSeq,
    int count = 100,
  }) async {
    final req = SyncRequest(lastSequence: startSeq, maxLimit: count);

    return _apiClient.post<List<ImMessage>>(
      "/v1/message/syncOfflineMessageList", // Corrected endpoint from "sync" to "syncOfflineMessageList"
      data: req.toJson(), // Backend expects SyncRequest
    );
  }
}
