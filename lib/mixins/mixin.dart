import 'dart:convert';

import 'package:im_sdk_core/im_sdk_core.dart';

/// IM SDK 基础工具 Mixin
///
/// 提供通用的工具方法，包括：
/// - 安全执行函数（错误捕获）
/// - JSON 数据格式化
///
/// 这些方法被 IMManager 及其各个子 Manager 使用
mixin BaseMixin {
  /// 安全执行函数
  ///
  /// 捕获函数执行过程中的错误，防止异常影响主流程
  ///
  /// [fn] 要执行的函数
  void safeExecute(Function fn) {
    try {
      fn();
    } catch (err, stackTrace) {
      Logger.error("函数执行错误", error: err, stackTrace: stackTrace);
    }
  }

  /// 格式化 JSON 数据
  ///
  /// 将任意对象转换为 `Map<String, dynamic>`
  /// 主要用于处理 MethodChannel 传递的数据
  Map<String, dynamic> formatJson(dynamic jsonSrc) {
    return json.decode(json.encode(jsonSrc));
  }
}
