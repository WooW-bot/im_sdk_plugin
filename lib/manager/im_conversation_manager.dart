import '../listener/im_conversation_listener.dart';
import '../models/im_callback.dart';
import '../models/im_conversation.dart';
import '../models/im_conversation_result.dart';
import '../models/im_value_callback.dart';
import '../models/im_conversation_operation_result.dart';
import '../models/im_conversation_list_filter.dart';

import '../core/im_core.dart';

/// 会话管理器
class IMConversationManager {
  final ImCore _imCore;

  IMConversationManager(this._imCore);

  /// 添加会话监听器
  Future<void> addConversationListener({
    required ImConversationListener listener,
  }) async {
    // TODO: implement addConversationListener
    throw UnimplementedError();
  }

  /// 移除会话监听器
  Future<void> removeConversationListener({
    ImConversationListener? listener,
  }) async {
    // TODO: implement removeConversationListener
    throw UnimplementedError();
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
    return _imCore.syncConversationList();
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
}
