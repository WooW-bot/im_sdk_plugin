import 'package:im_sdk_plugin/models/im_user_info.dart';

import '../im_sdk_plugin.dart';
import 'callbacks.dart';

/// 简单消息监听器
class ImSimpleMsgListener {
  /// 收到 C2C 自定义消息
  OnRecvC2CCustomMessageCallback onRecvC2CCustomMessage =
      (String msgID, ImUserInfo userInfo, String text) {};

  /// 收到 C2C 文本消息
  OnRecvC2CTextMessageCallback onRecvC2CTextMessage =
      (String msgID, ImUserInfo sender, String customData) {};

  /// 收到群组自定义消息
  OnRecvGroupCustomMessageCallback onRecvGroupCustomMessage =
      (String msgID, String groupID, ImGroupMemberInfo sender, String customData) {};

  /// 收到群组文本消息
  OnRecvGroupCustomMessageCallback onRecvGroupTextMessage =
      (String msgID, String groupID, ImGroupMemberInfo sender, String text) {};

  ImSimpleMsgListener({
    OnRecvC2CCustomMessageCallback? onRecvC2CCustomMessage,
    OnRecvC2CTextMessageCallback? onRecvC2CTextMessage,
    OnRecvGroupCustomMessageCallback? onRecvGroupCustomMessage,
    OnRecvGroupCustomMessageCallback? onRecvGroupTextMessage,
  }) {
    if (onRecvC2CCustomMessage != null) {
      this.onRecvC2CCustomMessage = onRecvC2CCustomMessage;
    }
    if (onRecvC2CTextMessage != null) {
      this.onRecvC2CTextMessage = onRecvC2CTextMessage;
    }
    if (onRecvGroupCustomMessage != null) {
      this.onRecvGroupCustomMessage = onRecvGroupCustomMessage;
    }
    if (onRecvGroupTextMessage != null) {
      this.onRecvGroupTextMessage = onRecvGroupTextMessage;
    }
  }
}
