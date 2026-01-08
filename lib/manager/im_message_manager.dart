import 'package:flutter/services.dart';

import '../enum/ImAdvancedMsgListener.dart';
import '../enum/get_group_message_read_member_list_filter.dart';
import '../enum/history_msg_get_type_enum.dart';
import '../enum/message_priority_enum.dart';
import '../enum/offlinePushInfo.dart';
import '../enum/receive_message_opt_enum.dart';
import '../models/im_callback.dart';
import '../models/im_group_message_read_member_list.dart';
import '../models/im_message.dart';
import '../models/im_message_change_info.dart';
import '../models/im_message_receipt.dart';
import '../models/im_message_search_param.dart';
import '../models/im_message_search_result.dart';
import '../models/im_msg_create_info_result.dart';
import '../models/im_value_callback.dart';

/// 消息管理器
abstract class IMMessageManager {
  late MethodChannel _channel;

  IMMessageManager(channel) {
    _channel = channel;
  }

  /// 创建文本消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createTextMessage({required String text});

  /// 创建自定义消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createCustomMessage({
    required String data,
    String desc = "",
    String extension = "",
  });

  /// 创建图片消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createImageMessage({
    required String imagePath,
    dynamic inputElement,
    String? imageName,
  });

  /// 创建语音消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createSoundMessage({
    required String soundPath,
    required int duration,
  });

  /// 创建视频消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createVideoMessage({
    required String videoFilePath,
    required String type,
    required int duration,
    required String snapshotPath,
    dynamic inputElement,
  });

  /// 创建 @ 消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createTextAtMessage({
    required String text,
    required List<String> atUserList,
  });

  /// 创建文件消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createFileMessage({
    required String filePath,
    required String fileName,
    dynamic inputElement,
  });

  /// 创建位置消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createLocationMessage({
    required String desc,
    required double longitude,
    required double latitude,
  });

  /// 创建表情消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createFaceMessage({
    required int index,
    required String data,
  });

  /// 创建合并消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createMergerMessage({
    required List<String> msgIDList,
    required String title,
    required List<String> abstractList,
    required String compatibleText,
  });

  /// 创建转发消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createForwardMessage({
    required String msgID,
    String? webMessageInstance,
  });

  /// 创建定向群消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createTargetedGroupMessage({
    required String id,
    required List<String> receiverList,
  });

  /// 添加元素到消息 (用于多元素消息)
  Future<ImValueCallback<ImMessage>> appendMessage({
    required String createMessageBaseId,
    required String createMessageAppendId,
  });

  /// 添加高级消息监听器
  Future<void> addAdvancedMsgListener({required ImAdvancedMsgListener listener});

  /// 移除高级消息监听器
  Future<void> removeAdvancedMsgListener({ImAdvancedMsgListener? listener});

  /// 获取 C2C 历史消息列表
  Future<ImValueCallback<List<ImMessage>>> getC2CHistoryMessageList({
    required String userID,
    required int count,
    String? lastMsgID,
  });

  /// 获取历史消息列表
  Future<ImValueCallback<List<ImMessage>>> getHistoryMessageList({
    HistoryMsgGetTypeEnum? getType = HistoryMsgGetTypeEnum.IM_GET_LOCAL_OLDER_MSG,
    String? userID,
    String? groupID,
    int lastMsgSeq = -1,
    required int count,
    String? lastMsgID,
    List<int>? messageTypeList,
  });

  /// 获取群组历史消息列表
  Future<ImValueCallback<List<ImMessage>>> getGroupHistoryMessageList({
    required String groupID,
    required int count,
    String? lastMsgID,
  });

  /// 标记 C2C 消息为已读
  Future<ImCallback> markC2CMessageAsRead({required String userID});

  /// 标记群组消息为已读
  Future<ImCallback> markGroupMessageAsRead({required String groupID});

  /// 标记所有消息为已读
  Future<ImCallback> markAllMessageAsRead();

  /// 从本地存储中删除消息
  Future<ImCallback> deleteMessageFromLocalStorage({required String msgID});

  /// 删除消息
  Future<ImCallback> deleteMessages({
    required List<String> msgIDs,
    List<dynamic>? webMessageInstanceList,
  });

  /// 插入群组消息到本地存储
  Future<ImValueCallback<ImMessage>> insertGroupMessageToLocalStorage({
    required String data,
    required String groupID,
    required String sender,
  });

  /// 插入 C2C 消息到本地存储
  Future<ImValueCallback<ImMessage>> insertC2CMessageToLocalStorage({
    required String data,
    required String userID,
    required String sender,
  });

  /// 清空 C2C 历史消息
  Future<ImCallback> clearC2CHistoryMessage({required String userID});

  /// 清空群组历史消息
  Future<ImCallback> clearGroupHistoryMessage({required String groupID});

  /// 下载合并消息
  Future<ImValueCallback<List<ImMessage>>> downloadMergerMessage({
    required String msgID,
    String? webMessageInstance,
  });

  /// 设置 C2C 消息接收选项
  Future<ImCallback> setC2CReceiveMessageOpt({
    required List<String> userIDList,
    required ReceiveMsgOptEnum opt,
  });

  /// 设置群组消息接收选项
  Future<ImCallback> setGroupReceiveMessageOpt({
    required String groupID,
    required ReceiveMsgOptEnum opt,
  });

  /// 设置本地自定义数据
  Future<ImCallback> setLocalCustomData({required String msgID, required String localCustomData});

  /// 设置本地自定义整数
  Future<ImCallback> setLocalCustomInt({required String msgID, required int localCustomInt});

  /// 撤回消息
  Future<ImCallback> revokeMessage({required String msgID, Object? webMessageInstatnce});

  /// 修改消息
  Future<ImValueCallback<ImMessageChangeInfo>> modifyMessage({required ImMessage message});

  /// 发送消息
  Future<ImValueCallback<ImMessage>> sendMessage({
    required String id, // 自己创建的ID
    required String receiver,
    required String groupID,
    MessagePriorityEnum? priority = MessagePriorityEnum.IM_PRIORITY_NORMAL,
    bool onlineUserOnly = false,
    bool isExcludedFromUnreadCount = false,
    bool isExcludedFromLastMessage = false,
    bool? isSupportMessageExtension = false,
    bool needReadReceipt = false,
    OfflinePushInfo? offlinePushInfo,
    String? cloudCustomData, // 云自定义消息字段，只能在消息发送前添加
    String? localCustomData,
  });

  /// 搜索本地消息
  Future<ImValueCallback<ImMessageSearchResult>> searchLocalMessages({
    required ImMessageSearchParam searchParam,
  });

  /// 发送消息已读回执
  Future<ImCallback> sendMessageReadReceipts({required List<String> messageIDList});

  /// 获取消息已读回执
  Future<ImValueCallback<List<ImMessageReceipt>>> getMessageReadReceipts({
    required List<String> messageIDList,
  });

  /// 获取群消息已读成员列表
  Future<ImValueCallback<ImGroupMessageReadMemberList>> getGroupMessageReadMemberList({
    required String messageID,
    required GetGroupMessageReadMemberListFilter filter,
    int nextSeq = 0,
    int count = 100,
  });
}
