import 'package:im_sdk_core/im_sdk_core.dart';
import 'package:im_sdk_plugin/mixins/mixin.dart';

import '../im_sdk_plugin.dart';
import '../listener/im_conversation_listener.dart';

/// 会话管理器
class IMConversationManager with BaseMixin {
  final ImSdkCore _imCore;

  ImConversationListener? _conversationListener;

  IMConversationManager(this._imCore);

  /// 设置会话监听器
  Future<void> setConversationListener(ImConversationListener? listener) async {
    Logger.debug(
      "[IMConversationManager] 设置会话监听器: ${listener != null ? '已设置' : '已清除'}",
    );
    _conversationListener = listener;
  }

  /// 获取会话列表 (Pagination)
  Future<ImValueCallback<ImConversationResult>> getConversationList({
    required String nextSeq,
    required int count,
  }) async {
    return _imCore.getConversationList(nextSeq: nextSeq, count: count);
  }

  /// 同意步会话列表 (Sync All/Recent on Login)
  Future<ImValueCallback<List<ImConversation>>> syncConversationList() async {
    return _imCore.syncConversationList();
  }

  /// 获取指定会话列表
  Future<ImValueCallback<List<ImConversation>>>
  getConversationListByConversationIds({
    required List<String> conversationIDList,
  }) async {
    return _imCore.getConversationListByConversationIds(
      conversationIDList: conversationIDList,
    );
  }

  /// 置顶会话
  Future<ImCallback> pinConversation({
    required String conversationID,
    required bool isPinned,
  }) async {
    return _imCore.pinConversation(
      conversationID: conversationID,
      isPinned: isPinned,
    );
  }

  /// 获取未读消息总数
  Future<ImValueCallback<int>> getTotalUnreadMessageCount() async {
    return _imCore.getTotalUnreadMessageCount();
  }

  /// 获取单个会话
  Future<ImValueCallback<ImConversation>> getConversation({
    required String conversationID,
  }) async {
    return _imCore.getConversation(conversationID: conversationID);
  }

  /// 删除会话
  Future<ImCallback> deleteConversation({
    required String conversationID,
  }) async {
    return _imCore.deleteConversation(conversationID: conversationID);
  }

  /// 设置会话草稿
  Future<ImCallback> setConversationDraft({
    required String conversationID,
    String? draftText = "",
  }) async {
    return _imCore.setConversationDraft(
      conversationID: conversationID,
      draftText: draftText,
    );
  }

  /// 创建会话分组
  Future<ImValueCallback<List<ImConversationOperationResult>>>
  createConversationGroup({
    required String groupName,
    required List<String> conversationIDList,
  }) async {
    return _imCore.createConversationGroup(
      groupName: groupName,
      conversationIDList: conversationIDList,
    );
  }

  /// 重命名会话分组
  Future<ImCallback> renameConversationGroup({
    required String oldName,
    required String newName,
  }) async {
    return _imCore.renameConversationGroup(oldName: oldName, newName: newName);
  }

  /// 获取会话分组列表
  Future<ImValueCallback<List<String>>> getConversationGroupList() async {
    return _imCore.getConversationGroupList();
  }

  /// 添加会话到分组
  Future<ImValueCallback<List<ImConversationOperationResult>>>
  addConversationsToGroup({
    required String groupName,
    required List<String> conversationIDList,
  }) async {
    return _imCore.addConversationsToGroup(
      groupName: groupName,
      conversationIDList: conversationIDList,
    );
  }

  /// 从分组删除会话
  Future<ImValueCallback<List<ImConversationOperationResult>>>
  deleteConversationsFromGroup({
    required String groupName,
    required List<String> conversationIDList,
  }) async {
    return _imCore.deleteConversationsFromGroup(
      groupName: groupName,
      conversationIDList: conversationIDList,
    );
  }

  /// 删除会话分组
  Future<ImCallback> deleteConversationGroup({
    required String groupName,
  }) async {
    return _imCore.deleteConversationGroup(groupName: groupName);
  }

  /// 设置会话自定义数据
  Future<ImValueCallback<List<ImConversationOperationResult>>>
  setConversationCustomData({
    required String customData,
    required List<String> conversationIDList,
  }) async {
    return _imCore.setConversationCustomData(
      customData: customData,
      conversationIDList: conversationIDList,
    );
  }

  /// 标记会话
  Future<ImValueCallback<List<ImConversationOperationResult>>>
  markConversation({
    required List<String> conversationIDList,
    required int markType,
    required bool enableMark,
  }) async {
    return _imCore.markConversation(
      conversationIDList: conversationIDList,
      markType: markType,
      enableMark: enableMark,
    );
  }

  /// 获取会话列表高级接口
  Future<ImValueCallback<ImConversationResult>> getConversationListByFilter({
    required ImConversationListFilter filter,
  }) async {
    return _imCore.getConversationListByFilter(filter: filter);
  }

  void handleConversationCallback(MethodCall call) {
    Logger.debug("[IMConversationManager] 收到会话回调");
    if (_conversationListener == null) {
      Logger.warn("[IMConversationManager] 会话监听器未设置");
      return;
    }
    final listener = _conversationListener!;

    Map<String, dynamic> data = formatJson(call.arguments);
    String type = data['type'];
    Logger.debug("[IMConversationManager] 处理会话事件: $type");

    safeExecute(() {
      switch (type) {
        case 'onSyncServerStart':
          listener.onSyncServerStart();
          break;
        case 'onSyncServerFinish':
          listener.onSyncServerFinish();
          break;
        case 'onSyncServerFailed':
          listener.onSyncServerFailed();
          break;
        case 'onNewConversation':
          dynamic params = data['data'] == null
              ? List.empty(growable: true)
              : List.from(data['data']);
          List<ImConversation> conversationList = List.empty(growable: true);
          params.forEach((element) {
            conversationList.add(ImConversation.fromJson(element));
          });
          listener.onNewConversation(conversationList);
          break;
        case 'onConversationChanged':
          dynamic params = data['data'] == null
              ? List.empty(growable: true)
              : List.from(data['data']);
          List<ImConversation> conversationList = List.empty(growable: true);
          params.forEach((element) {
            conversationList.add(ImConversation.fromJson(element));
          });
          listener.onConversationChanged(conversationList);
          break;
        case 'onTotalUnreadMessageCountChanged':
          dynamic params = data['data'] ?? 0;
          listener.onTotalUnreadMessageCountChanged(params);
          break;
        case "onConversationGroupCreated":
          Map<String, dynamic> param = data["data"];
          String groupName = param["groupName"];
          List<ImConversation> list = List.empty(growable: true);
          List.from(param["conversationList"]).forEach((v) {
            list.add(ImConversation.fromJson(v));
          });
          listener.onConversationGroupCreated(groupName, list);
          break;
        case "onConversationGroupDeleted":
          listener.onConversationGroupDeleted(data["data"]);
          break;
        case "onConversationGroupNameChanged":
          Map<String, dynamic> param = data["data"];
          listener.onConversationGroupNameChanged(
            param["oldName"],
            param["newName"],
          );
          break;
        case "onConversationsAddedToGroup":
          Map<String, dynamic> param = data["data"];
          String groupName = param["groupName"];
          List<ImConversation> list = List.empty(growable: true);
          for (var v in List.from(param["conversationList"])) {
            list.add(ImConversation.fromJson(v));
          }
          listener.onConversationsAddedToGroup(groupName, list);
          break;
        case "onConversationsDeletedFromGroup":
          Map<String, dynamic> param = data["data"];
          String groupName = param["groupName"];
          List<ImConversation> list = List.empty(growable: true);
          for (var v in List.from(param["conversationList"])) {
            list.add(ImConversation.fromJson(v));
          }
          listener.onConversationsDeletedFromGroup(groupName, list);
          break;
      }
    });
  }
}
