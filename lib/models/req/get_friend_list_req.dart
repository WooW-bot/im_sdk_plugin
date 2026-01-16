class GetFriendListReq {
  String userId;

  GetFriendListReq({required this.userId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromId'] = userId;
    return data;
  }
}
