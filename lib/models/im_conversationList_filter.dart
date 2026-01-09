/// 会话列表过滤器
class ImConversationListFilter {
  /// 会话类型
  int? conversationType;

  /// 下一次拉取的序列号
  int? nextSeq;

  /// 拉取数量
  int? count;

  /// 标记类型
  int? markType;

  /// 分组名称
  String? groupName;

  ImConversationListFilter({
    this.conversationType,
    this.nextSeq,
    this.markType,
    this.groupName,
    this.count,
  });

  ImConversationListFilter.fromJson(Map<String, dynamic> json) {
    conversationType = json['conversationType'];
    nextSeq = json['nextSeq'];
    markType = json['markType'];
    groupName = json['groupName'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversationType'] = conversationType;
    data['nextSeq'] = nextSeq;
    data['markType'] = markType;
    data['groupName'] = groupName;
    data['count'] = count;
    return data;
  }
}
