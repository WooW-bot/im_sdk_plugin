enum HistoryMsgGetTypeEnum {
  ///不要使用，dart枚举站位
  ///
  IM_NULL,

  ///获取云端更老的消息
  ///
  IM_GET_CLOUD_OLDER_MSG,

  ///获取云端更新的消息
  ///
  IM_GET_CLOUD_NEWER_MSG,

  ///获取本地更老的消息
  ///
  IM_GET_LOCAL_OLDER_MSG,

  ///获取本地更新的消息
  ///
  IM_GET_LOCAL_NEWER_MSG,
}
