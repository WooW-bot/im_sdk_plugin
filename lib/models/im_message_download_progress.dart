class ImMessageDownloadProgress {
  /// 是否完成
  late bool isFinish;

  /// 是否出错
  late bool isError;

  /// 消息 ID
  late String msgID;

  /// 当前下载大小
  late int currentSize;

  /// 总大小
  late int totalSize;

  /// 下载类型
  late int type;

  /// 是否是快照
  late bool isSnapshot;

  /// 下载路径
  late String path;

  /// 错误码
  late int errorCode;

  /// 错误描述
  late String errorDesc;

  ImMessageDownloadProgress({
    required this.isFinish,
    required this.isError,
    required this.msgID,
    required this.totalSize,
    required this.currentSize,
    required this.type,
    required this.isSnapshot,
    required this.path,
    required this.errorCode,
    required this.errorDesc,
  });

  ImMessageDownloadProgress.fromJson(Map<String, dynamic> json) {
    isFinish = json["isFinish"];
    isError = json["isError"];
    msgID = json["msgID"];
    currentSize = json["currentSize"];
    totalSize = json["totalSize"];
    type = json["type"];
    isSnapshot = json["isSnapshot"];
    path = json["path"];
    errorCode = json["errorCode"];
    errorDesc = json["errorDesc"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["isFinish"] = isFinish;
    data["isError"] = isError;
    data["msgID"] = msgID;
    data["currentSize"] = currentSize;
    data["totalSize"] = totalSize;
    data["type"] = type;
    data["isSnapshot"] = isSnapshot;
    data["path"] = path;
    data["errorCode"] = errorCode;
    data["errorDesc"] = errorDesc;
    return data;
  }
}
