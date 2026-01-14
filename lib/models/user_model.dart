class GetUserInfoReq {
  List<String> userIds;

  GetUserInfoReq({required this.userIds});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userIds'] = userIds;
    return data;
  }
}
