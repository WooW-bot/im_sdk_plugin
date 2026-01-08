import 'im_group_info.dart';

class ImGroupInfoResult {
  /// 结果码
  late int? resultCode;

  /// 结果信息
  late String? resultMessage;

  /// 群组信息
  late ImGroupInfo? groupInfo;

  ImGroupInfoResult({this.resultCode, this.resultMessage, this.groupInfo});

  ImGroupInfoResult.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultMessage = json['resultMessage'];
    groupInfo = ImGroupInfo.fromJson(json['groupInfo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resultCode'] = resultCode;
    data['resultMessage'] = resultMessage;
    data['groupInfo'] = groupInfo?.toJson();
    return data;
  }
}

// {
//   "resultCode":0,
//   "resultMessage":"",
//   "groupInfo":{}
// }
