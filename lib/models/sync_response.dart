class SyncResponse<T> {
  List<T>? dataList;
  int? maxSequence;
  bool? completed;

  SyncResponse({this.dataList, this.maxSequence, this.completed});

  SyncResponse.fromJson(
    Map<String, dynamic> json,
    Function(Map<String, dynamic>) fromJsonT,
  ) {
    if (json['dataList'] != null) {
      dataList = <T>[];
      json['dataList'].forEach((v) {
        dataList!.add(fromJsonT(v));
      });
    }
    maxSequence = json['maxSequence'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson(Function(T) toJsonT) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataList != null) {
      data['dataList'] = dataList!.map((v) => toJsonT(v)).toList();
    }
    data['maxSequence'] = maxSequence;
    data['completed'] = completed;
    return data;
  }
}
