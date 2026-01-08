import 'package:flutter/services.dart';

/// 消息管理器
abstract class IMMessageManager {
  late MethodChannel _channel;

  IMMessageManager(channel) {
    _channel = channel;
  }
}
