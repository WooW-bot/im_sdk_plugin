class GetUserInfoReq {
  final List<String> userIds;

  GetUserInfoReq({required this.userIds});

  Map<String, dynamic> toJson() {
    return {'userIDList': userIds};
  }
}
