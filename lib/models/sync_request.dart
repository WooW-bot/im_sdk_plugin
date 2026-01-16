class SyncRequest {
  /// 客户端最大 Seq
  int? lastSequence;

  /// 一次性最大拉取多少
  int? maxLimit;

  SyncRequest({this.lastSequence, this.maxLimit});

  SyncRequest.fromJson(Map<String, dynamic> json) {
    lastSequence = json['lastSequence'];
    maxLimit = json['maxLimit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastSequence'] = lastSequence;
    data['maxLimit'] = maxLimit;
    return data;
  }
}
