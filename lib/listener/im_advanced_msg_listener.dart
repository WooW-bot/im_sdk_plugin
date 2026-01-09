import '../models/im_message.dart';
import '../models/im_message_download_progress.dart';
import '../models/im_message_extension.dart';
import '../models/im_message_receipt.dart';
import 'callbacks.dart';

/// 高级消息监听器
class ImAdvancedMsgListener {
  /// 收到新消息回调
  OnRecvNewMessageCallback onRecvNewMessage = (ImMessage message) {};

  /// 收到消息被修改回调
  OnRecvMessageModified onRecvMessageModified = (ImMessage message) {};

  /// 消息发送进度回调
  OnSendMessageProgressCallback onSendMessageProgress = (ImMessage message, int progress) {};

  /// 收到 C2C 消息已读回执回调
  OnRecvC2CReadReceiptCallback onRecvC2CReadReceipt = (List<ImMessageReceipt> receiptList) {};

  /// 收到消息撤回回调
  OnRecvMessageRevokedCallback onRecvMessageRevoked = (String msgID) {};

  /// 收到消息已读回执回调
  OnRecvMessageReadReceipts onRecvMessageReadReceipts = (List<ImMessageReceipt> receiptList) {};

  /// 收到消息扩展修改回调
  OnRecvMessageExtensionsChanged onRecvMessageExtensionsChanged =
      (String msgID, List<ImMessageExtension> extensions) {};

  /// 收到消息扩展删除回调
  OnRecvMessageExtensionsDeleted onRecvMessageExtensionsDeleted =
      (String msgID, List<String> extensionKeys) {};

  /// 消息下载进度回调
  OnMessageDownloadProgressCallback onMessageDownloadProgressCallback =
      (ImMessageDownloadProgress messageDownloadProgress) {};

  ImAdvancedMsgListener({
    OnRecvC2CReadReceiptCallback? onRecvC2CReadReceipt,
    OnRecvMessageRevokedCallback? onRecvMessageRevoked,
    OnRecvNewMessageCallback? onRecvNewMessage,
    OnSendMessageProgressCallback? onSendMessageProgress,
    OnRecvMessageModified? onRecvMessageModified,
    OnRecvMessageReadReceipts? onRecvMessageReadReceipts,
    OnRecvMessageExtensionsChanged? onRecvMessageExtensionsChanged,
    OnRecvMessageExtensionsDeleted? onRecvMessageExtensionsDeleted,
    OnMessageDownloadProgressCallback? onMessageDownloadProgressCallback,
  }) {
    if (onRecvC2CReadReceipt != null) {
      this.onRecvC2CReadReceipt = onRecvC2CReadReceipt;
    }
    if (onRecvMessageRevoked != null) {
      this.onRecvMessageRevoked = onRecvMessageRevoked;
    }
    if (onRecvNewMessage != null) {
      this.onRecvNewMessage = onRecvNewMessage;
    }
    if (onSendMessageProgress != null) {
      this.onSendMessageProgress = onSendMessageProgress;
    }
    if (onRecvMessageModified != null) {
      this.onRecvMessageModified = onRecvMessageModified;
    }
    if (onRecvMessageReadReceipts != null) {
      this.onRecvMessageReadReceipts = onRecvMessageReadReceipts;
    }
    if (onRecvMessageExtensionsChanged != null) {
      this.onRecvMessageExtensionsChanged = onRecvMessageExtensionsChanged;
    }
    if (onRecvMessageExtensionsDeleted != null) {
      this.onRecvMessageExtensionsDeleted = onRecvMessageExtensionsDeleted;
    }
    if (onMessageDownloadProgressCallback != null) {
      this.onMessageDownloadProgressCallback = onMessageDownloadProgressCallback;
    }
  }
}
