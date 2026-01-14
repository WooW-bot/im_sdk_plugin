class LoginReq {
  final int appId;
  final String userId;
  final int? clientType;
  final String? imei;
  final String? operator;

  LoginReq({
    required this.appId,
    required this.userId,
    this.clientType,
    this.imei,
    this.operator,
  });

  Map<String, dynamic> toJson() {
    return {
      'appId': appId,
      'userId': userId,
      'clientType': clientType,
      'imei': imei,
      'operator': operator,
    };
  }
}

class RouteInfo {
  final String ip;
  final int port;

  RouteInfo({required this.ip, required this.port});

  factory RouteInfo.fromJson(Map<String, dynamic> json) {
    return RouteInfo(ip: json['ip'] ?? "", port: json['port'] ?? 0);
  }
}
