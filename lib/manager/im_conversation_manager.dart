import 'package:im_sdk_core/im_sdk_core.dart';
import 'package:im_sdk_core/method_call_handler.dart';
import 'package:im_sdk_plugin/mixins/mixin.dart';

import '../im_sdk_plugin.dart';
import '../listener/im_conversation_listener.dart';
import '../models/im_conversation.dart';
import '../models/im_conversation_result.dart';
import '../models/im_conversation_operation_result.dart';
import '../models/im_conversation_list_filter.dart';

import '../core/im_core.dart';

/// 会话管理器
class IMConversationManager with BaseMixin {
  final ImSdkCore _imCore;

  ImConversationListener? _conversationListener;

  IMConversationManager(this._imCore);

  /// 设置会话监听器
  Future<void> setConversationListener(ImConversationListener? listener) async {
    Logger.debug("[IMConversationManager] 设置会话监听器: ${listener != null ? '已设置' : '已清除'}");
    _conversationListener = listener;
  }

  /// 获取会话列表 (Pagination)
  Future<ImValueCallback<ImConversationResult>> getConversationList({
    required String nextSeq,
    required int count,
  }) async {
    // TODO: implement getConversationList
    throw UnimplementedError();
  }

  /// 同意步会话列表 (Sync All/Recent on Login)
  Future<ImValueCallback<List<ImConversation>>> syncConversationList() async {
    // TODO: implement getConversationListByConversationIds
    throw UnimplementedError();
  }

  /// 获取指定会话列表
  Future<ImValueCallback<List<ImConversation>>>
  getConversationListByConversationIds({
    required List<String> conversationIDList,
  }) async {
    // TODO: implement getConversationListByConversationIds
    throw UnimplementedError();
  }

  /// 置顶会话
  Future<ImCallback> pinConversation({
    required String conversationID,
    required bool isPinned,
  }) async {
    // TODO: implement pinConversation
    throw UnimplementedError();
  }

  /// 获取未读消息总数
  Future<ImValueCallback<int>> getTotalUnreadMessageCount() async {
    // TODO: implement getTotalUnreadMessageCount
    throw UnimplementedError();
  }

  /// 获取单个会话
  Future<ImValueCallback<ImConversation>> getConversation({
    required String conversationID,
  }) async {
    // TODO: implement getConversation
    throw UnimplementedError();
  }

  /// 删除会话
  Future<ImCallback> deleteConversation({
    required String conversationID,
  }) async {
    // TODO: implement deleteConversation
    throw UnimplementedError();
  }

  /// 设置会话草稿
  Future<ImCallback> setConversationDraft({
    required String conversationID,
    String? draftText = "",
  }) async {
    // TODO: implement setConversationDraft
    throw UnimplementedError();
  }

  /// 创建会话分组
  Future<ImValueCallback<List<ImConversationOperationResult>>>
  createConversationGroup({
    required String groupName,
    required List<String> conversationIDList,
  }) async {
    // TODO: implement createConversationGroup
    throw UnimplementedError();
  }

  /// 重命名会话分组
  Future<ImCallback> renameConversationGroup({
    required String oldName,
    required String newName,
  }) async {
    // TODO: implement renameConversationGroup
    throw UnimplementedError();
  }

  /// 获取会话分组列表
  Future<ImValueCallback<List<String>>> getConversationGroupList() async {
    // TODO: implement getConversationGroupList
    throw UnimplementedError();
  }

  /// 添加会话到分组
  Future<ImValueCallback<List<ImConversationOperationResult>>>
  addConversationsToGroup({
    required String groupName,
    required List<String> conversationIDList,
  }) async {
    // TODO: implement addConversationsToGroup
    throw UnimplementedError();
  }

  /// 从分组删除会话
  Future<ImValueCallback<List<ImConversationOperationResult>>>
  deleteConversationsFromGroup({
    required String groupName,
    required List<String> conversationIDList,
  }) async {
    // TODO: implement deleteConversationsFromGroup
    throw UnimplementedError();
  }

  /// 删除会话分组
  Future<ImCallback> deleteConversationGroup({
    required String groupName,
  }) async {
    // TODO: implement deleteConversationGroup
    throw UnimplementedError();
  }

  /// 设置会话自定义数据
  Future<ImValueCallback<List<ImConversationOperationResult>>>
  setConversationCustomData({
    required String customData,
    required List<String> conversationIDList,
  }) async {
    // TODO: implement setConversationCustomData
    throw UnimplementedError();
  }

  /// 标记会话
  Future<ImValueCallback<List<ImConversationOperationResult>>>
  markConversation({
    required List<String> conversationIDList,
    required int markType,
    required bool enableMark,
  }) async {
    // TODO: implement markConversation
    throw UnimplementedError();
  }

  /// 获取会话列表高级接口
  Future<ImValueCallback<ImConversationResult>> getConversationListByFilter({
    required ImConversationListFilter filter,
  }) async {
    // TODO: implement getConversationListByFilter
    throw UnimplementedError();
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
