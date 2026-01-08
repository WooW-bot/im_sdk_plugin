import 'package:flutter/services.dart';

/// 会话管理器
abstract class IMConversationManager {
  late MethodChannel _channel;

  IMConversationManager(channel) {
    _channel = channel;
  }
}
