import 'package:flutter_test/flutter_test.dart';
import 'package:im_sdk_plugin/core/net/api_client.dart';
import 'package:im_sdk_plugin/core/net/auth_api.dart';
import 'package:im_sdk_plugin/core/net/user_api.dart';
import 'package:im_sdk_plugin/core/net/friendship_api.dart';
import 'package:im_sdk_plugin/core/net/group_api.dart';
import 'package:im_sdk_plugin/core/net/conversation_api.dart';
import 'package:im_sdk_plugin/core/net/message_api.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/models/im_callback.dart';
import 'package:im_sdk_plugin/models/sdk_context.dart';
import 'package:im_sdk_plugin/enums/friend_type_enum.dart';

// Mock ApiClient to capture requests and return dummy data
class MockApiClient extends ApiClient {
  MockApiClient(SDKContext sdkContext) : super(sdkContext);

  String? lastPath;
  Map<String, dynamic>? lastData;

  @override
  Future<ImValueCallback<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    lastPath = path;
    lastData = data;
    // Return a dummy success response
    // For T=List, we return empty list. For others, likely null or basic types.
    // Since we are mocking, we can just return a generic success.
    // Casting is tricky with generics in mocks without proper mocking lib.
    // But ImValueCallback.success(data: null) should work for most checks where we only care about the request.
    return ImValueCallback(code: 0, msg: "Mock Success", data: null);
  }

  @override
  Future<ImCallback> postNoResult(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    lastPath = path;
    lastData = data;
    return ImCallback(code: 0, msg: "Mock Success");
  }
}

void main() {
  late MockApiClient mockApiClient;
  late SDKContext sdkContext;

  setUp(() {
    sdkContext = SDKContext();
    mockApiClient = MockApiClient(sdkContext);
  });

  group('AuthApi Tests', () {
    late AuthApi authApi;

    setUp(() {
      authApi = AuthApi(mockApiClient);
    });

    test('login sends correct request', () async {
      await authApi.login(appID: 123456, userID: 'user1', clientType: 1);

      expect(mockApiClient.lastPath, '/v1/user/login');
      expect(mockApiClient.lastData, {
        'appId': 123456,
        'userId': 'user1',
        'clientType': 1,
        'imei': null,
        'operator': null,
      });
    });
  });

  group('UserApi Tests', () {
    late UserApi userApi;

    setUp(() {
      userApi = UserApi(mockApiClient);
    });

    test('getUsersInfo sends correct request', () async {
      await userApi.getUsersInfo(userIDs: ['u1', 'u2']);

      expect(mockApiClient.lastPath, '/v1/user/data/getUserInfo');
      expect(mockApiClient.lastData, {
        'userIDList': ['u1', 'u2'],
      });
    });

    test('importUser sends correct request', () async {
      final data = {'userId': 'u1', 'nickname': 'Test'};
      await userApi.importUser(data);
      expect(mockApiClient.lastPath, '/v1/user/importUser');
      expect(mockApiClient.lastData, data);
    });
  });

  group('FriendshipApi Tests', () {
    late FriendshipApi friendshipApi;

    setUp(() {
      friendshipApi = FriendshipApi(mockApiClient);
    });

    test('getFriendList sends correct request', () async {
      await friendshipApi.getFriendList('user1');

      expect(mockApiClient.lastPath, '/v1/friendship/getAllFriendShip');
      expect(mockApiClient.lastData, {'fromId': 'user1'});
    });

    test('checkFriend sends correct request', () async {
      await friendshipApi.checkFriend(
        fromUserID: 'u1',
        toUserIDs: ['u2'],
        checkType: FriendTypeEnum.IM_FRIEND_TYPE_SINGLE,
      );

      expect(mockApiClient.lastPath, '/v1/friendship/checkFriend');
      expect(mockApiClient.lastData, {
        'fromId': 'u1',
        'toIds': ['u2'],
        'checkType': 1,
      });
    });

    test('addFriend sends correct request', () async {
      final data = {'fromId': 'u1', 'toId': 'u2'};
      await friendshipApi.addFriend(data);
      expect(mockApiClient.lastPath, '/v1/friendship/addFriend');
      expect(mockApiClient.lastData, data);
    });
  });

  group('GroupApi Tests', () {
    late GroupApi groupApi;

    setUp(() {
      groupApi = GroupApi(mockApiClient);
    });

    test('getJoinedGroupList sends correct request', () async {
      await groupApi.getJoinedGroupList('user1');

      expect(mockApiClient.lastPath, '/v1/group/getJoinedGroup');
      expect(mockApiClient.lastData, {'fromId': 'user1'});
    });

    test('createGroup sends correct request', () async {
      final data = {'ownerId': 'u1', 'groupName': 'TestGroup'};
      await groupApi.createGroup(data);
      expect(mockApiClient.lastPath, '/v1/group/createGroup');
      expect(mockApiClient.lastData, data);
    });
  });

  group('ConversationApi Tests', () {
    late ConversationApi conversationApi;

    setUp(() {
      conversationApi = ConversationApi(mockApiClient);
    });

    test('syncConversationList sends correct request', () async {
      await conversationApi.syncConversationList('user1');

      expect(mockApiClient.lastPath, '/v1/conversation/syncConversationList');
      expect(mockApiClient.lastData, {'lastSequence': 0, 'maxLimit': 100});
    });

    test('updateConversation sends correct request', () async {
      final data = {'conversationId': 'c1', 'isPinned': true};
      await conversationApi.updateConversation(data);
      expect(mockApiClient.lastPath, '/v1/conversation/updateConversation');
      expect(mockApiClient.lastData, data);
    });
  });

  group('MessageApi Tests', () {
    late MessageApi messageApi;

    setUp(() {
      messageApi = MessageApi(mockApiClient);
    });

    test('syncOfflineMessages sends correct request', () async {
      await messageApi.syncOfflineMessages(
        userID: 'user1',
        startSeq: 10,
        count: 50,
      );

      expect(mockApiClient.lastPath, '/v1/message/syncOfflineMessageList');
      expect(mockApiClient.lastData, {'lastSequence': 10, 'maxLimit': 50});
    });

    test('send message sends correct request', () async {
      final data = {'fromId': 'u1', 'text': 'Hello'};
      await messageApi.send(data);
      expect(mockApiClient.lastPath, '/v1/message/send');
      expect(mockApiClient.lastData, data);
    });
  });
}
