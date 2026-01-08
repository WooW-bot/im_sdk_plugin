import '../models/im_message.dart';
import '../models/im_message_download_progress.dart';
import '../models/im_message_extension.dart';
import '../models/im_message_receipt.dart';
import 'callbacks.dart';

class ImAdvancedMsgListener {
  OnRecvNewMessageCallback onRecvNewMessage = (ImMessage message) {};
  OnRecvMessageModified onRecvMessageModified = (ImMessage message) {};
  OnSendMessageProgressCallback onSendMessageProgress = (ImMessage message, int progress) {};
  OnRecvC2CReadReceiptCallback onRecvC2CReadReceipt = (List<ImMessageReceipt> receiptList) {};
  OnRecvMessageRevokedCallback onRecvMessageRevoked = (String msgID) {};
  OnRecvMessageReadReceipts onRecvMessageReadReceipts = (List<ImMessageReceipt> receiptList) {};
  OnRecvMessageExtensionsChanged onRecvMessageExtensionsChanged =
      (String msgID, List<ImMessageExtension> extensions) {};
  OnRecvMessageExtensionsDeleted onRecvMessageExtensionsDeleted =
      (String msgID, List<String> extensionKeys) {};
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
