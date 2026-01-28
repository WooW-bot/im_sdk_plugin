import '../../im_sdk_plugin.dart';
import '../../models/sync_request.dart';
import 'api_client.dart';

class ConversationApi {
  final ApiClient _apiClient;

  ConversationApi(this._apiClient);

  /// 删除会话
  Future<ImValueCallback<dynamic>> deleteConversation(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/conversation/deleteConversation", data: data);
  }

  /// 更新会话 (置顶/免打扰/草稿)
  Future<ImValueCallback<dynamic>> updateConversation(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/conversation/updateConversation", data: data);
  }

  /// 同步会话列表 (Full/Incremental based on SyncRequest)
  Future<ImValueCallback<List<ImConversation>>> syncConversationList(
    String userID,
  ) async {
    // Note: The previous ImCore used a different endpoint/logic.
    // Backend controller uses "syncConversationList" which takes SyncRequest.
    // If we want simple list, maybe syncLogic handled there?
    // Let's check backend controller again:
    // @RequestMapping("/syncConversationList") public ResponseVO syncConversationList(@RequestBody @Validated SyncRequest req, Integer appId)
    // So it expects a SyncRequest.
    // The previous ImCore code: "/v1/conversation/getAllConversationList" with {'fromId': userID}.
    // Backend doesn't seem to have "getAllConversationList" in the file I read.
    // It has "syncConversationList".
    // I should update this to use "syncConversationList" or finding if "getAllConversationList" exists elsewhere?
    // User requested to REFER TO BACKEND INTERFACES. So I should use "syncConversationList".
    // But wait, ImCore was using "getAllConversationList". If that endpoint doesn't exist, ImCore was broken?
    // Or maybe I missed a controller? No, I searched all controllers.
    // It's possible "getAllConversationList" was an old endpoint or I missed it.
    // But "ConversationController.java" has "syncConversationList".
    // Let's implement "syncConversationList" correctly.

    // For now, I'll provide a method that matches the Controller.
    final req = SyncRequest(
      lastSequence: 0,
      maxLimit: 100,
    ); // Default full sync?
    // But wait, ImCore.dart call was:
    // final result = await _conversationApi.syncConversationList(_sdkContext.currentUserID!);

    // I will overload or just change implementation.
    // Use the correct endpoint.

    return _apiClient.post<List<ImConversation>>(
      "/v1/conversation/syncConversationList",
      data: req.toJson(),
    );
  }

  /// Sync with manual parameters
  Future<ImValueCallback<dynamic>> syncConversationListWithParams(
    Map<String, dynamic> data,
  ) async {
    return _apiClient.post("/v1/conversation/syncConversationList", data: data);
  }
}
