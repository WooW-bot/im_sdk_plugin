import 'package:flutter/services.dart';

import '../enum/ImConversationListener.dart';
import '../models/im_callback.dart';
import '../models/im_conversation.dart';
import '../models/im_conversation_result.dart';
import '../models/im_value_callback.dart';

/// 会话管理器
abstract class IMConversationManager {
  late MethodChannel _channel;

  IMConversationManager(channel) {
    _channel = channel;
  }

  /// 添加会话监听器
  Future<void> addConversationListener({required ImConversationListener listener});

  /// 移除会话监听器
  Future<void> removeConversationListener({ImConversationListener? listener});

  /// 获取会话列表
  Future<ImValueCallback<ImConversationResult>> getConversationList({
    required String nextSeq,
    required int count,
  });

  /// 获取指定会话列表
  Future<ImValueCallback<List<ImConversation>>> getConversationListByConversationIds({
    required List<String> conversationIDList,
  });

  /// 置顶会话
  Future<ImCallback> pinConversation({required String conversationID, required bool isPinned});

  /// 获取未读消息总数
  Future<ImValueCallback<int>> getTotalUnreadMessageCount();

  /// 获取单个会话
  Future<ImValueCallback<ImConversation>> getConversation({required String conversationID});

  /// 删除会话
  Future<ImCallback> deleteConversation({required String conversationID});

  /// 设置会话草稿
  Future<ImCallback> setConversationDraft({required String conversationID, String? draftText = ""});
}
