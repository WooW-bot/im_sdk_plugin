class ImGroupMemberOperationResult {
  /// 成员 ID
  late String? memberID;

  /// 结果
  late int? result;

  ImGroupMemberOperationResult({this.memberID, this.result});

  ImGroupMemberOperationResult.fromJson(Map<String, dynamic> json) {
    memberID = json['memberID'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberID'] = memberID;
    data['result'] = result;
    return data;
  }
}

// {
//   "memberID":"",
//   "result":0,
// }
