enum LogLevelEnum {
  /// 无日志
  IM_LOG_NONE,

  /// dart枚举占位，不可使用
  IM_NULL,

  /// 全量日志
  IM_LOG_ALL,

  /// 输出 DEBUG，INFO，WARNING，ERROR 级别的 log
  IM_LOG_DEBUG,

  /// 输出 INFO，WARNING，ERROR 级别的 log
  IM_LOG_INFO,

  /// 输出 WARNING，ERROR 级别的 log
  IM_LOG_WARN,

  /// 输出 ERROR 级别的 log
  IM_LOG_ERROR,
}
