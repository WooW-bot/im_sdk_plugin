class ImMessageSearchParam {
  /// 会话 ID
  String? conversationID;

  /// 关键字列表
  late List<String> keywordList;

  /// 搜索类型
  late int type;

  /// 用户 ID 列表
  List<String>? userIDList = [];

  /// 消息类型列表
  List<int>? messageTypeList = [];

  /// 搜索起始时间点
  int? searchTimePosition;

  /// 搜索时间范围
  int? searchTimePeriod;

  /// 每页数量
  int? pageSize = 100;

  /// 页码
  int? pageIndex = 0;

  ImMessageSearchParam({
    required this.type,
    required this.keywordList,
    this.conversationID,
    this.userIDList,
    this.messageTypeList,
    this.searchTimePosition,
    this.searchTimePeriod,
    this.pageSize,
    this.pageIndex,
  });

  ImMessageSearchParam.fromJson(Map<String, dynamic> json) {
    conversationID = json['conversationID'];
    keywordList = json['keywordList'] == null
        ? List.empty(growable: true)
        : json['keywordList'].cast<String>();
    type = json['type'];
    userIDList = json['userIDList'] == null
        ? List.empty(growable: true)
        : json['userIDList'].cast<String>();
    messageTypeList = json['messageTypeList'] == null
        ? List.empty(growable: true)
        : json['messageTypeList'].cast<int>();
    searchTimePosition = json['searchTimePosition'];
    searchTimePeriod = json['searchTimePeriod'];
    pageSize = json['pageSize'];
    pageIndex = json['pageIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversationID'] = conversationID;
    data['keywordList'] = keywordList;
    data['type'] = type;
    data['userIDList'] = userIDList ?? List.empty(growable: true);
    data['messageTypeList'] = messageTypeList ?? List.empty(growable: true);
    data['searchTimePosition'] = searchTimePosition;
    data['searchTimePeriod'] = searchTimePeriod;
    data['pageSize'] = pageSize;
    data['pageIndex'] = pageIndex;
    return data;
  }
}
