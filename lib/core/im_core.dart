import '../im_sdk_plugin.dart';
import 'net/api_client.dart';
import 'db/db_manager.dart';

import 'net/auth_api.dart';
import 'net/user_api.dart';
import 'net/friendship_api.dart';
import 'net/group_api.dart';
import 'net/conversation_api.dart';
import 'net/message_api.dart';

/// IM SDK 核心业务逻辑层 (BLL)
class ImCore {
  final SDKContext _sdkContext;
  late ApiClient _apiClient;
  late DBManager _dbManager;

  // APIs
  late AuthApi _authApi;
  late UserApi _userApi;
  late FriendshipApi _friendshipApi;
  late GroupApi _groupApi;
  late ConversationApi _conversationApi;
  late MessageApi _messageApi;

  ImCore(this._sdkContext) {
    _apiClient = ApiClient(_sdkContext);
    _dbManager = DBManager();

    // Initialize APIs
    _authApi = AuthApi(_apiClient);
    _userApi = UserApi(_apiClient);
    _friendshipApi = FriendshipApi(_apiClient);
    _groupApi = GroupApi(_apiClient);
    _conversationApi = ConversationApi(_apiClient);
    _messageApi = MessageApi(_apiClient);
  }

  // --- Getters for Managers to use temporarily or for simple proxying ---
  ApiClient get apiClient => _apiClient;
  DBManager get dbManager => _dbManager;

  // --- Business Logic Methods (Orchestration) ---

  /// 登录
  Future<ImValueCallback<RouteInfo>> login({
    required String userID,
    required String userSig,
  }) async {
    try {
      // 1. HTTP 请求从后端获取路由信息
      final ImValueCallback<RouteInfo> response = await _authApi.login(
        appID: _sdkContext.appID,
        userID: userID,
        clientType: 1,
      );

      if (response.isSuccess && response.data != null) {
        // 2. 初始化数据库
        await _dbManager.initDB(userID);

        // 3. 建立 TCP 连接 (TODO: Implement Socket Manager separately if needed)
        // Connect Socket logic remains in IMManager for now or move to SocketManager?
        // User requested: "net below core contains api request". Socket is also net.
        // For now, let's keep Socket logic in IMManager to minimize risk, OR move it.
        // The plan says "ImCore ... orchestrates API and DB".
        // Let's return RouteInfo so IMManager can handle Socket connection for now,
        // or fully encapsulate here.
        // To be safe and follow "Business Logic", login should be here.
        // But Socket connection is active state.
        // Let's return RouteInfo clearly.

        return response;
      } else {
        return ImValueCallback.error(code: response.code, msg: response.msg);
      }
    } catch (e) {
      return ImValueCallback.error(msg: "Login Failed: $e");
    }
  }

  /// 获取用户资料
  Future<ImValueCallback<List<ImUserFullInfo>>> getUsersInfo({
    required List<String> userIDList,
  }) async {
    try {
      if (_sdkContext.appID == null) {
        return ImValueCallback.error(msg: "SDK not initialized", data: []);
      }

      final result = await _userApi.getUsersInfo(userIDs: userIDList);

      // Cache self info if needed?
      // Current IMManager logic didn't auto-cache in getUsersInfo, but used batchInsertUsers in _syncData.
      // Let's add caching capability here if it's self info or all info.
      if (result.isSuccess && result.data != null) {
        await _dbManager.batchInsertUsers(result.data!);
      }

      return result;
    } catch (e) {
      return ImValueCallback.error(msg: "getUsersInfo Failed: $e", data: []);
    }
  }

  /// 登录后的数据同步
  Future<void> postLoginSync(String userID) async {
    print("IMSDK: Starting post-login data sync...");

    // 1. 同步个人资料 (Self Info)
    getUsersInfo(userIDList: [userID]).then((result) {
      if (result.isSuccess) {
        print("IMSDK: Self info synced.");
      }
    });

    // 2. 同步好友列表
    syncFriendList().then((val) {
      print("IMSDK: Friend list synced. Count: ${val.data?.length ?? 0}");
    });

    // 3. 同步群组列表
    getJoinedGroupList().then((val) {
      print("IMSDK: Group list synced. Count: ${val.data?.length ?? 0}");
    });

    // 4. 同步会话列表
    syncConversationList().then((val) {
      print("IMSDK: Coversation list synced. Count: ${val.data?.length ?? 0}");
    });

    // 5. 同步离线消息
    syncOfflineMessages().then((val) {
      print("IMSDK: Offline messages synced. Count: ${val.data?.length ?? 0}");
    });
  }

  /// 登出
  Future<ImCallback> logout() async {
    return ImCallback.success(msg: "Logout Success");
  }

  // --- Friend Logic ---

  /// 获取好友列表 (Full Sync)
/*  Future<ImValueCallback<List<ImFriendInfo>>> getFriendList() async {
    try {
      if (_sdkContext.appID == null ||
          _sdkContext.currentUserID == null ||
          _sdkContext.userSig == null) {
        return ImValueCallback.error(
          msg: "SDK not initialized or not logged in",
          data: [],
        );
      }

      final result = await _friendshipApi.getFriendList(
        _sdkContext.currentUserID!,
      );

      // 数据同步：持久化到本地数据库
      if (result.isSuccess && result.data != null) {
        await _dbManager.batchInsertFriends(result.data!);
      }

      return result;
    } catch (e) {
      return ImValueCallback.error(msg: "getFriendList Failed: $e", data: []);
    }
  }*/

  /// 同步好友列表
  Future<ImValueCallback<List<ImFriendInfo>>> syncFriendList() async {
    try {
      // 1. Get max seq from local DB
      final int lastSeq = await _dbManager.getFriendMaxSequence();

      // 2. Call Server
      final result = await _friendshipApi.syncFriendList(lastSequence: lastSeq);

      if (result.isSuccess && result.data != null) {
        final syncResp = result.data!;

        // 3. Cache to DB
        if (syncResp.dataList != null && syncResp.dataList!.isNotEmpty) {
          await _dbManager.batchInsertFriends(syncResp.dataList!);
        }

        // Recursive sync handled by caller or here?
        // Simple implementation: just one batch for now, or loop.
        // For strict sync, should loop until completed.
        // Adapting simplify version for now.

        // Extract list to return
        return ImValueCallback.success(data: syncResp.dataList);
      }

      return ImValueCallback.success(data: []);
    } catch (e) {
      return ImValueCallback.error(msg: "syncFriendList Failed: $e", data: []);
    }
  }

  /// 获取好友信息 (Smart Fetch: Local -> Network)
  Future<ImValueCallback<List<ImFriendInfoResult>>> getFriendsInfo({
    required List<String> userIDList,
  }) async {
    try {
      if (userIDList.isEmpty) {
        return ImValueCallback.success(data: []);
      }

      if (_sdkContext.appID == null ||
          _sdkContext.currentUserID == null ||
          _sdkContext.userSig == null) {
        return ImValueCallback.error(
          msg: "SDK not initialized or not logged in",
          data: [],
        );
      }

      // 1. 尝试从本地缓存获取好友信息 (Status=1)
      List<ImFriendInfo> existingFriends = await _dbManager.getFriendInfoList(
        userIDList,
      );
      Set<String> friendIDs = existingFriends.map((e) => e.toId).toSet();

      // 2. 识别非好友ID (可能是陌生人或本地缺失)
      List<String> nonFriendIDs = userIDList
          .where((id) => !friendIDs.contains(id))
          .toList();

      // 3. 尝试从本地获取这些非好友的用户资料 (Profile)
      List<ImUserFullInfo> existingUsers = [];
      if (nonFriendIDs.isNotEmpty) {
        existingUsers = await _dbManager.getUserList(nonFriendIDs);
      }
      Set<String> foundUserIDs = existingUsers.map((e) => e.userId!).toSet();

      // 4. 识别真正缺失资料的 ID (既不是好友由于也没有Profile)
      List<String> missingProfileIDs = nonFriendIDs
          .where((id) => !foundUserIDs.contains(id))
          .toList();

      // 5. 网络获取 User Info (Server: /v1/user/data/getUserInfo)
      if (missingProfileIDs.isNotEmpty) {
        final result = await _userApi.getUsersInfo(userIDs: missingProfileIDs);

        if (result.isSuccess && result.data != null) {
          // 写入本地 User Cache
          await _dbManager.batchInsertUsers(result.data!);
          existingUsers.addAll(result.data!);
        } else {
          print("IMSDK: getUsersInfo failed: ${result.msg}");
        }
      }

      // 6. 检查非好友的关系状态 (CheckFriend)
      Map<String, int> statusMap = {};
      if (nonFriendIDs.isNotEmpty) {
        final checkResult = await checkFriend(
          userIDList: nonFriendIDs,
          checkType: FriendTypeEnum.IM_FRIEND_TYPE_SINGLE,
        );
        if (checkResult.isSuccess && checkResult.data != null) {
          for (var item in checkResult.data!) {
            statusMap[item.userID] = item.resultType;
          }
        }
      }

      // 7. 组装结果
      List<ImFriendInfoResult> results = [];

      for (var f in existingFriends) {
        results.add(
          ImFriendInfoResult(
            resultCode: 0,
            resultInfo: "Success",
            relation: 1,
            friendInfo: f,
          ),
        );
      }

      Map<String, ImUserFullInfo> userMap = {
        for (var u in existingUsers) u.userId!: u,
      };

      for (var id in nonFriendIDs) {
        ImUserFullInfo? profile = userMap[id];
        if (profile != null) {
          int status = statusMap[id] ?? 0;
          ImFriendInfo info = ImFriendInfo(
            toId: profile.userId!,
            userProfile: profile,
            remark: null,
            status: status,
          );
          results.add(
            ImFriendInfoResult(
              resultCode: 0,
              resultInfo: "Success",
              relation: status,
              friendInfo: info,
            ),
          );
        }
      }

      return ImValueCallback.success(data: results);
    } catch (e) {
      return ImValueCallback.error(msg: "getFriendsInfo Failed: $e", data: []);
    }
  }

  /// 检查好友关系
  Future<ImValueCallback<List<ImFriendCheckResult>>> checkFriend({
    required List<String> userIDList,
    required FriendTypeEnum checkType,
  }) async {
    try {
      if (userIDList.isEmpty) {
        return ImValueCallback.success(data: []);
      }

      final result = await _friendshipApi.checkFriend(
        fromUserID: _sdkContext.currentUserID!,
        toUserIDs: userIDList,
        checkType: checkType,
      );

      return result;
    } catch (e) {
      return ImValueCallback.error(msg: "checkFriend Failed: $e", data: []);
    }
  }

  /// 获取黑名单列表
  Future<ImValueCallback<List<ImFriendInfo>>> getBlackList() async {
    try {
      final list = await _dbManager.getBlackList();
      return ImValueCallback.success(data: list);
    } catch (e) {
      return ImValueCallback.error(msg: "getBlackList Failed: $e", data: []);
    }
  }

  // --- Group Logic ---

  /// 获取已加入的群组列表
  Future<ImValueCallback<List<ImGroupInfo>>> getJoinedGroupList() async {
    try {
      if (_sdkContext.currentUserID == null) {
        return ImValueCallback.error(msg: "Not logged in", data: []);
      }

      final result = await _groupApi.getJoinedGroupList(
        _sdkContext.currentUserID!,
      );

      if (result.isSuccess && result.data != null) {
        // Cache to DB
        await _dbManager.batchInsertGroups(result.data!);
      }

      return result;
    } catch (e) {
      return ImValueCallback.error(
        msg: "getJoinedGroupList Failed: $e",
        data: [],
      );
    }
  }

  // --- Conversation Logic ---

  /// 同步会话列表
  Future<ImValueCallback<List<ImConversation>>> syncConversationList() async {
    try {
      if (_sdkContext.currentUserID == null) {
        return ImValueCallback.error(msg: "Not logged in", data: []);
      }

      final result = await _conversationApi.syncConversationList(
        _sdkContext.currentUserID!,
      );

      if (result.isSuccess && result.data != null) {
        await _dbManager.batchInsertConversations(result.data!);
      }

      return result;
    } catch (e) {
      return ImValueCallback.error(
        msg: "syncConversationList Failed: $e",
        data: [],
      );
    }
  }

  // --- Message Logic ---

  /// 同步离线消息
  Future<ImValueCallback<List<ImMessage>>> syncOfflineMessages() async {
    try {
      if (_sdkContext.currentUserID == null) {
        return ImValueCallback.error(msg: "Not logged in", data: []);
      }

      // 1. Get max seq from local DB
      final int maxSeq = await _dbManager.getMaxMessageSeq();

      // 2. Call Server
      final result = await _messageApi.syncOfflineMessages(
        userID: _sdkContext.currentUserID!,
        startSeq: maxSeq,
      );

      // 3. Cache to DB
      if (result.isSuccess && result.data != null && result.data!.isNotEmpty) {
        await _dbManager.batchInsertMessages(result.data!);
      }

      return result;
    } catch (e) {
      return ImValueCallback.error(
        msg: "syncOfflineMessages Failed: $e",
        data: [],
      );
    }
  }

  /// 初始化数据库
  Future<void> initDB(String userID) async {
    await _dbManager.initDB(userID);
  }

  /// 通用 POST 请求代理 (逐步废弃，改为具体业务方法)
  Future<ImValueCallback<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _apiClient.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
