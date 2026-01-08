import 'im_elem.dart';

class ImVideoElem extends IMElem {
  /// 视频路径
  late String? videoPath;

  // ignore: non_constant_identifier_names
  /// 视频 UUID
  late String? UUID;

  /// 视频大小
  late int? videoSize;

  /// 时长
  late int? duration;

  /// 快照路径
  late String? snapshotPath;

  /// 快照 UUID
  late String? snapshotUUID;

  /// 快照大小
  late int? snapshotSize;

  /// 快照宽度
  late int? snapshotWidth;

  /// 快照高度
  late int? snapshotHeight;

  /// 视频下载 URL
  late String? videoUrl;

  /// 快照下载 URL
  late String? snapshotUrl;

  /// 本地视频 URL
  String? localVideoUrl;

  /// 本地快照 URL
  String? localSnapshotUrl;

  ImVideoElem({
    this.videoPath,
    // ignore: non_constant_identifier_names
    this.UUID,
    this.videoSize,
    this.duration,
    this.snapshotPath,
    this.snapshotUUID,
    this.snapshotSize,
    this.snapshotWidth,
    this.snapshotHeight,
    this.videoUrl,
    this.snapshotUrl,
    this.localVideoUrl,
    this.localSnapshotUrl,
  });

  ImVideoElem.fromJson(Map<String, dynamic> json) {
    videoPath = json['videoPath'];
    UUID = json['UUID'];
    videoSize = json['videoSize'];
    duration = json['duration'];
    snapshotPath = json['snapshotPath'];
    snapshotUUID = json['snapshotUUID'];
    snapshotSize = json['snapshotSize'];
    snapshotWidth = json['snapshotWidth'];
    snapshotHeight = json['snapshotHeight'];
    videoUrl = json['videoUrl'];
    snapshotUrl = json['snapshotUrl'];
    localVideoUrl = json['localVideoUrl'];
    localSnapshotUrl = json['localSnapshotUrl'];
    if (json['nextElem'] != null) {
      nextElem = Map<String, dynamic>.from(json['nextElem']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoPath'] = videoPath;
    data['UUID'] = UUID;
    data['videoSize'] = videoSize;
    data['duration'] = duration;
    data['snapshotPath'] = snapshotPath;
    data['snapshotUUID'] = snapshotUUID;
    data['snapshotSize'] = snapshotSize;
    data['snapshotWidth'] = snapshotWidth;
    data['snapshotHeight'] = snapshotHeight;
    data['videoUrl'] = videoUrl;
    data['snapshotUrl'] = snapshotUrl;
    data['localVideoUrl'] = localVideoUrl;
    data['localSnapshotUrl'] = localSnapshotUrl;
    if (nextElem != null) {
      data['nextElem'] = nextElem;
    }
    return data;
  }
}
