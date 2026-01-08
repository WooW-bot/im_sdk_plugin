enum ReceiveMsgOptEnum {
  //在线正常接收消息，离线时会进行离线推送
  IM_RECEIVE_MESSAGE,
  //不会接收到消息
  IM_NOT_RECEIVE_MESSAGE,
  //在线正常接收消息，离线不会有推送通知
  IM_RECEIVE_NOT_NOTIFY_MESSAGE,
}
