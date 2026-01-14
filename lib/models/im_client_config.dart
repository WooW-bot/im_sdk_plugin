/// Configuration for the IM SDK Client initialization.
///
/// Similar to `ImBootstrapConfig` in the server implementation, this class
/// holds the startup parameters required for the IM engine.
class IMClientConfig {
  /// The AppID assigned by Tencent Cloud.
  final int appID;

  /// Logging level (e.g., 0: None, 1: Error, 2: Info, 3: Debug).
  final int logLevel;

  /// Whether to print IM logs to the console.
  final bool showImLog;

  /// The root directory for storing local data (DB, Logs, etc.).
  /// If null, a default path in the app's document directory will be used.
  final String? dataDir;

  /// Application specific listener UUID.
  final String listenerUuid;

  /// UI Platform identifier (e.g., Flutter, Unity, Unreal).
  final int uiPlatform;

  /// The API Host URL (e.g., "http://127.0.0.1:8080").
  final String apiHost;

  IMClientConfig({
    required this.appID,
    required this.logLevel,
    required this.listenerUuid,
    required this.uiPlatform,
    required this.apiHost,
    this.showImLog = false,
    this.dataDir,
  });

  @override
  String toString() {
    return 'IMClientConfig{appID: $appID, logLevel: $logLevel, showImLog: $showImLog, dataDir: $dataDir, listenerUuid: $listenerUuid}';
  }
}
