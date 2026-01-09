/// 获取群消息已读（未读）成员列表type
enum GetGroupMessageReadMemberListFilter {
  ///禁止加群
  ///
  IM_GROUP_MESSAGE_READ_MEMBERS_FILTER_READ,

  ///需要管理员审批
  ///
  IM_GROUP_MESSAGE_READ_MEMBERS_FILTER_UNREAD,
}
