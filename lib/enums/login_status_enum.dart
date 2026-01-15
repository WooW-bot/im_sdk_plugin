/// 登录状态枚举
enum LoginStatusEnum {
  /// 限制状态 (未初始化或已销毁)
  limit, // 0
  /// 未登录/已登出
  logout, // 1
  /// 登录中
  logging, // 2
  /// 已登录
  logged, // 3
}
