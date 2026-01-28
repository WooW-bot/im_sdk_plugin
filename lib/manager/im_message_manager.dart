import 'package:im_sdk_core/im_sdk_core.dart';
import 'package:im_sdk_plugin/mixins/mixin.dart';
import 'package:im_sdk_plugin/models/im_message_download_progress.dart';

import '../im_sdk_plugin.dart';
import '../listener/im_advanced_msg_listener.dart';
import 'dart:collection';

/// 消息管理器
class IMMessageManager with BaseMixin {
  final ImSdkCore _imCore;
  ImAdvancedMsgListener? _advancedMsgListener;

  IMMessageManager(this._imCore);

  /// 设置高级消息监听器
  Future<void> setAdvancedMsgListener(ImAdvancedMsgListener? listener) async {
    Logger.debug(
      "[IMMessageManager] 设置消息监听器: ${listener != null ? '已设置' : '已清除'}",
    );
    _advancedMsgListener = listener;
  }

  /// 创建文本消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createTextMessage({
    required String text,
  }) async {
    return _imCore.createTextMessage(text: text);
  }

  /// 创建自定义消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createCustomMessage({
    required String data,
    String desc = "",
    String extension = "",
  }) async {
    return _imCore.createCustomMessage(
      data: data,
      desc: desc,
      extension: extension,
    );
  }

  /// 创建图片消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createImageMessage({
    required String imagePath,
    dynamic inputElement,
    String? imageName,
  }) async {
    return _imCore.createImageMessage(
      imagePath: imagePath,
      inputElement: inputElement,
      imageName: imageName,
    );
  }

  /// 创建语音消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createSoundMessage({
    required String soundPath,
    required int duration,
  }) async {
    return _imCore.createSoundMessage(soundPath: soundPath, duration: duration);
  }

  /// 创建视频消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createVideoMessage({
    required String videoFilePath,
    required String type,
    required int duration,
    required String snapshotPath,
    dynamic inputElement,
  }) async {
    return _imCore.createVideoMessage(
      videoFilePath: videoFilePath,
      type: type,
      duration: duration,
      snapshotPath: snapshotPath,
      inputElement: inputElement,
    );
  }

  /// 创建 @ 消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createTextAtMessage({
    required String text,
    required List<String> atUserList,
  }) async {
    return _imCore.createTextAtMessage(text: text, atUserList: atUserList);
  }

  /// 创建文件消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createFileMessage({
    required String filePath,
    required String fileName,
    dynamic inputElement,
  }) async {
    return _imCore.createFileMessage(
      filePath: filePath,
      fileName: fileName,
      inputElement: inputElement,
    );
  }

  /// 创建位置消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createLocationMessage({
    required String desc,
    required double longitude,
    required double latitude,
  }) async {
    return _imCore.createLocationMessage(
      desc: desc,
      longitude: longitude,
      latitude: latitude,
    );
  }

  /// 创建表情消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createFaceMessage({
    required int index,
    required String data,
  }) async {
    return _imCore.createFaceMessage(index: index, data: data);
  }

  /// 创建合并消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createMergerMessage({
    required List<String> msgIDList,
    required String title,
    required List<String> abstractList,
    required String compatibleText,
  }) async {
    return _imCore.createMergerMessage(
      msgIDList: msgIDList,
      title: title,
      abstractList: abstractList,
      compatibleText: compatibleText,
    );
  }

  /// 创建转发消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createForwardMessage({
    required String msgID,
    String? webMessageInstance,
  }) async {
    return _imCore.createForwardMessage(
      msgID: msgID,
      webMessageInstance: webMessageInstance,
    );
  }

  /// 创建定向群消息
  Future<ImValueCallback<ImMsgCreateInfoResult>> createTargetedGroupMessage({
    required String id,
    required List<String> receiverList,
  }) async {
    return _imCore.createTargetedGroupMessage(
      id: id,
      receiverList: receiverList,
    );
  }

  /// 添加元素到消息 (用于多元素消息)
  Future<ImValueCallback<ImMessage>> appendMessage({
    required String createMessageBaseId,
    required String createMessageAppendId,
  }) async {
    return _imCore.appendMessage(
      createMessageBaseId: createMessageBaseId,
      createMessageAppendId: createMessageAppendId,
    );
  }

  /// 获取 C2C 历史消息列表
  Future<ImValueCallback<List<ImMessage>>> getC2CHistoryMessageList({
    required String userID,
    required int count,
    String? lastMsgID,
  }) async {
    return _imCore.getC2CHistoryMessageList(
      userID: userID,
      count: count,
      lastMsgID: lastMsgID,
    );
  }

  /// 获取历史消息列表
  Future<ImValueCallback<List<ImMessage>>> getHistoryMessageList({
    HistoryMsgGetTypeEnum? getType =
        HistoryMsgGetTypeEnum.IM_GET_LOCAL_OLDER_MSG,
    String? userID,
    String? groupID,
    int lastMsgSeq = -1,
    required int count,
    String? lastMsgID,
    List<int>? messageTypeList,
  }) async {
    return _imCore.getHistoryMessageList(
      getType: getType,
      userID: userID,
      groupID: groupID,
      lastMsgSeq: lastMsgSeq,
      count: count,
      lastMsgID: lastMsgID,
      messageTypeList: messageTypeList,
    );
  }

  /// 获取群组历史消息列表
  Future<ImValueCallback<List<ImMessage>>> getGroupHistoryMessageList({
    required String groupID,
    required int count,
    String? lastMsgID,
  }) async {
    return _imCore.getGroupHistoryMessageList(
      groupID: groupID,
      count: count,
      lastMsgID: lastMsgID,
    );
  }

  /// 标记 C2C 消息为已读
  Future<ImCallback> markC2CMessageAsRead({required String userID}) async {
    return _imCore.markC2CMessageAsRead(userID: userID);
  }

  /// 标记群组消息为已读
  Future<ImCallback> markGroupMessageAsRead({required String groupID}) async {
    return _imCore.markGroupMessageAsRead(groupID: groupID);
  }

  /// 标记所有消息为已读
  Future<ImCallback> markAllMessageAsRead() async {
    return _imCore.markAllMessageAsRead();
  }

  /// 从本地存储中删除消息
  Future<ImCallback> deleteMessageFromLocalStorage({
    required String msgID,
  }) async {
    return _imCore.deleteMessageFromLocalStorage(msgID: msgID);
  }

  /// 删除消息
  Future<ImCallback> deleteMessages({
    required List<String> msgIDs,
    List<dynamic>? webMessageInstanceList,
  }) async {
    return _imCore.deleteMessages(
      msgIDs: msgIDs,
      webMessageInstanceList: webMessageInstanceList,
    );
  }

  /// 插入群组消息到本地存储
  Future<ImValueCallback<ImMessage>> insertGroupMessageToLocalStorage({
    required String data,
    required String groupID,
    required String sender,
  }) async {
    return _imCore.insertGroupMessageToLocalStorage(
      data: data,
      groupID: groupID,
      sender: sender,
    );
  }

  /// 插入 C2C 消息到本地存储
  Future<ImValueCallback<ImMessage>> insertC2CMessageToLocalStorage({
    required String data,
    required String userID,
    required String sender,
  }) async {
    return _imCore.insertC2CMessageToLocalStorage(
      data: data,
      userID: userID,
      sender: sender,
    );
  }

  /// 清空 C2C 历史消息
  Future<ImCallback> clearC2CHistoryMessage({required String userID}) async {
    return _imCore.clearC2CHistoryMessage(userID: userID);
  }

  /// 清空群组历史消息
  Future<ImCallback> clearGroupHistoryMessage({required String groupID}) async {
    return _imCore.clearGroupHistoryMessage(groupID: groupID);
  }

  /// 下载合并消息
  Future<ImValueCallback<List<ImMessage>>> downloadMergerMessage({
    required String msgID,
    String? webMessageInstance,
  }) async {
    return _imCore.downloadMergerMessage(
      msgID: msgID,
      webMessageInstance: webMessageInstance,
    );
  }

  /// 设置 C2C 消息接收选项
  Future<ImCallback> setC2CReceiveMessageOpt({
    required List<String> userIDList,
    required ReceiveMsgOptEnum opt,
  }) async {
    return _imCore.setC2CReceiveMessageOpt(userIDList: userIDList, opt: opt);
  }

  /// 设置群组消息接收选项
  Future<ImCallback> setGroupReceiveMessageOpt({
    required String groupID,
    required ReceiveMsgOptEnum opt,
  }) async {
    return _imCore.setGroupReceiveMessageOpt(groupID: groupID, opt: opt);
  }

  /// 设置本地自定义数据
  Future<ImCallback> setLocalCustomData({
    required String msgID,
    required String localCustomData,
  }) async {
    return _imCore.setLocalCustomData(
      msgID: msgID,
      localCustomData: localCustomData,
    );
  }

  /// 设置本地自定义整数
  Future<ImCallback> setLocalCustomInt({
    required String msgID,
    required int localCustomInt,
  }) async {
    return _imCore.setLocalCustomInt(
      msgID: msgID,
      localCustomInt: localCustomInt,
    );
  }

  /// 撤回消息
  Future<ImCallback> revokeMessage({
    required String msgID,
    Object? webMessageInstance,
  }) async {
    return _imCore.revokeMessage(
      msgID: msgID,
      webMessageInstance: webMessageInstance,
    );
  }

  /// 修改消息
  Future<ImValueCallback<ImMessageChangeInfo>> modifyMessage({
    required ImMessage message,
  }) async {
    return _imCore.modifyMessage(message: message);
  }

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
  }) async {
    return _imCore.sendMessage(
      id: id,
      receiver: receiver,
      groupID: groupID,
      priority: priority,
      onlineUserOnly: onlineUserOnly,
      isExcludedFromUnreadCount: isExcludedFromUnreadCount,
      isExcludedFromLastMessage: isExcludedFromLastMessage,
      isSupportMessageExtension: isSupportMessageExtension,
      needReadReceipt: needReadReceipt,
      offlinePushInfo: offlinePushInfo,
      cloudCustomData: cloudCustomData,
      localCustomData: localCustomData,
    );
  }

  /// 搜索本地消息
  Future<ImValueCallback<ImMessageSearchResult>> searchLocalMessages({
    required ImMessageSearchParam searchParam,
  }) async {
    return _imCore.searchLocalMessages(searchParam: searchParam);
  }

  /// 发送消息已读回执
  Future<ImCallback> sendMessageReadReceipts({
    required List<String> messageIDList,
  }) async {
    return _imCore.sendMessageReadReceipts(messageIDList: messageIDList);
  }

  /// 获取消息已读回执
  Future<ImValueCallback<List<ImMessageReceipt>>> getMessageReadReceipts({
    required List<String> messageIDList,
  }) async {
    return _imCore.getMessageReadReceipts(messageIDList: messageIDList);
  }

  /// 获取群消息已读成员列表
  Future<ImValueCallback<ImGroupMessageReadMemberList>>
  getGroupMessageReadMemberList({
    required String messageID,
    required GetGroupMessageReadMemberListFilter filter,
    int nextSeq = 0,
    int count = 100,
  }) async {
    return _imCore.getGroupMessageReadMemberList(
      messageID: messageID,
      filter: filter,
      nextSeq: nextSeq,
      count: count,
    );
  }

  /// 下载合并消息
  Future<ImCallback> downloadMessage({
    required String msgID,
    required int imageType,
    required bool isSnapshot,
    int? messageType,
  }) async {
    return _imCore.downloadMessage(
      msgID: msgID,
      imageType: imageType,
      isSnapshot: isSnapshot,
      messageType: messageType,
    );
  }

  /// 获取消息在线 URL
  Future<ImValueCallback<ImMessageOnlineUrl>> getMessageOnlineUrl({
    required String msgID,
  }) async {
    return _imCore.getMessageOnlineUrl(msgID: msgID);
  }

  /// 设置消息扩展
  Future<ImValueCallback<List<ImMessageExtensionResult>>> setMessageExtensions({
    required String msgID,
    required List<ImMessageExtension> extensions,
  }) async {
    return _imCore.setMessageExtensions(msgID: msgID, extensions: extensions);
  }

  /// 获取消息扩展
  Future<ImValueCallback<List<ImMessageExtension>>> getMessageExtensions({
    required String msgID,
  }) async {
    return _imCore.getMessageExtensions(msgID: msgID);
  }

  /// 删除消息扩展
  Future<ImValueCallback<List<ImMessageExtensionResult>>>
  deleteMessageExtensions({
    required String msgID,
    required List<String> keys,
  }) async {
    return _imCore.deleteMessageExtensions(msgID: msgID, keys: keys);
  }

  /// 设置云端自定义数据
  Future<ImCallback> setCloudCustomData({
    required String msgID,
    required String data,
  }) async {
    return _imCore.setCloudCustomData(msgID: msgID, data: data);
  }

  /// 同步离线消息
  Future<ImValueCallback<List<ImMessage>>> syncOfflineMessages() async {
    return _imCore.syncOfflineMessages();
  }

  /// 查找消息
  Future<ImValueCallback<List<ImMessage>>> findMessages({
    required List<String> messageIDList,
  }) async {
    return _imCore.findMessages(messageIDList: messageIDList);
  }

  /// 获取 C2C 消息接收选项
  Future<ImValueCallback<dynamic>> getC2CReceiveMessageOpt({
    required List<String> userIDList,
  }) async {
    return _imCore.getC2CReceiveMessageOpt(userIDList: userIDList);
  }

  /// 重发消息
  Future<ImValueCallback<ImMessage>> reSendMessage({
    required String msgID,
    bool onlineUserOnly = false,
  }) async {
    return _imCore.reSendMessage(msgID: msgID, onlineUserOnly: onlineUserOnly);
  }

  /// 发送自定义消息
  Future<ImValueCallback<ImMessage>> sendCustomMessage({
    required String data,
    required String receiver,
    required String groupID,
  }) async {
    return _imCore.sendCustomMessage(
      data: data,
      receiver: receiver,
      groupID: groupID,
    );
  }

  /// 获取历史消息列表高级接口
  Future<ImValueCallback<ImMessageListResult>> getHistoryMessageListV2({
    String? userID,
    String? groupID,
    int? count,
    String? lastMsgID,
    HistoryMsgGetTypeEnum? getType,
    List<int>? messageTypeList,
  }) async {
    return _imCore.getHistoryMessageListV2(
      userID: userID,
      groupID: groupID,
      count: count,
      lastMsgID: lastMsgID,
      getType: getType,
      messageTypeList: messageTypeList,
    );
  }

  /// 获取历史消息列表（不格式化）
  Future<LinkedHashMap<dynamic, dynamic>> getHistoryMessageListWithoutFormat({
    String? userID,
    String? groupID,
    int? count,
    String? lastMsgID,
    HistoryMsgGetTypeEnum? getType,
  }) async {
    return _imCore.getHistoryMessageListWithoutFormat(
      userID: userID,
      groupID: groupID,
      count: count,
      lastMsgID: lastMsgID,
      getType: getType,
    );
  }

  void handleAdvancedMsgCallback(MethodCall call) {
    Logger.debug("[IMMessageManager] 收到消息回调");
    if (_advancedMsgListener == null) {
      Logger.warn("[IMMessageManager] 消息监听器未设置");
      return;
    }
    final listener = _advancedMsgListener!;

    final Map<String, dynamic> data = formatJson(call.arguments);
    final String type = data['type'];
    Logger.debug("[IMMessageManager] 处理消息事件: $type");

    final dynamic params = data['data'] ?? <String, dynamic>{};

    safeExecute(() {
      switch (type) {
        case 'onRecvNewMessage':
          listener.onRecvNewMessage(ImMessage.fromJson(params));
          break;
        case 'onRecvMessageModified':
          listener.onRecvMessageModified(ImMessage.fromJson(params));
          break;
        case 'onRecvC2CReadReceipt':
          List dataList = params;
          List<ImMessageReceipt> receiptList = List.empty(growable: true);
          for (var element in dataList) {
            receiptList.add(ImMessageReceipt.fromJson(element));
          }
          listener.onRecvC2CReadReceipt(receiptList);
          break;
        case 'onRecvMessageRevoked':
          listener.onRecvMessageRevoked(params);
          break;
        case 'onSendMessageProgress':
          final message = ImMessage.fromJson(params['message']);
          listener.onSendMessageProgress(message, params['progress']);
          break;
        case 'onRecvMessageReadReceipts':
          List dataList = params;
          List<ImMessageReceipt> receiptList = List.empty(growable: true);
          for (var element in dataList) {
            receiptList.add(ImMessageReceipt.fromJson(element));
          }
          listener.onRecvMessageReadReceipts(receiptList);
          break;
        case "onRecvMessageExtensionsChanged":
          Map<String, dynamic> cbdata = Map<String, Object>.from(params);
          String msgID = cbdata["msgID"] ?? "";
          List<Map<String, dynamic>> extensions = List.from(
            cbdata["extensions"] ?? [],
          );
          List<ImMessageExtension> resList = List.empty(growable: true);
          for (var element in extensions) {
            resList.add(
              ImMessageExtension(
                extensionKey: element["element"] ?? "",
                extensionValue: element["extensionValue"] ?? "",
              ),
            );
          }
          listener.onRecvMessageExtensionsChanged(msgID, resList);
          break;
        case "onRecvMessageExtensionsDeleted":
          Map<String, dynamic> cbdata = Map<String, dynamic>.from(params);
          String msgID = cbdata["msgID"] ?? "";
          List<String> extensionKeys = List.from(cbdata["extensionKeys"] ?? []);
          listener.onRecvMessageExtensionsDeleted(msgID, extensionKeys);
          break;
        case "onMessageDownloadProgressCallback":
          Map<String, dynamic> cbdata = Map<String, dynamic>.from(params);
          listener.onMessageDownloadProgressCallback(
            ImMessageDownloadProgress.fromJson(cbdata),
          );
          break;
        default:
          Logger.warn('未知的 AdvancedMsg 事件类型: $type');
      }
    });
  }
}
