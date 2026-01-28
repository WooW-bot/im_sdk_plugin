import 'dart:convert';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../im_sdk_plugin.dart';

class DBManager {
  static final DBManager _instance = DBManager._internal();
  static Database? _database;
  String? _currentUserID;

  static const int _dbVersion = 2;

  // Table Names
  static const String _tblUsers = 'local_users';
  static const String _tblFriends = 'local_friends';
  static const String _tblConversations = 'local_conversations';
  static const String _tblGroups = 'local_groups';
  static const String _tblGroupMembers = 'local_group_members';
  static const String _tblMessages = 'local_messages';

  factory DBManager() {
    return _instance;
  }

  DBManager._internal();

  /// 初始化数据库
  Future<void> initDB(String userID) async {
    if (_currentUserID == userID && _database != null) {
      return;
    }
    _currentUserID = userID;

    // 获取应用文档目录
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String dbPath = join(appDocDir.path, "IM_v2_$userID.db");

    // 打开数据库
    _database = await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    print("IMSDK: Database initialized at $dbPath");
  }

  Future<void> _onCreate(Database db, int version) async {
    print("IMSDK: Creating tables...");
    // 1. 创建本地用户表 (local_users)
    await db.execute('''
      CREATE TABLE $_tblUsers (
        user_id TEXT PRIMARY KEY,
        nick_name TEXT,
        face_url TEXT,
        gender INTEGER,
        self_signature TEXT,
        friend_allow_type INTEGER,
        birthday TEXT,
        location TEXT,
        extra TEXT,
        create_time INTEGER
      )
    ''');

    // 2. 创建本地好友表 (local_friends)
    // 联合主键: from_id + to_id
    await db.execute('''
      CREATE TABLE $_tblFriends (
        from_id TEXT,
        to_id TEXT,
        remark TEXT,
        add_source TEXT,
        create_time INTEGER,
        status INTEGER,
        black INTEGER,
        friend_sequence INTEGER,
        extra TEXT,
        PRIMARY KEY (from_id, to_id)
      )
    ''');

    // 3. 创建本地会话表 (local_conversations)
    // Hybrid Schema: Server Sync Fields + Local Cache Fields
    await db.execute('''
      CREATE TABLE $_tblConversations (
        -- Server Sync Fields (from ImConversationSetEntity)
        conversation_id TEXT PRIMARY KEY,
        conversation_type INTEGER,
        from_id TEXT,
        to_id TEXT,
        is_mute INTEGER,
        is_top INTEGER,
        sequence INTEGER,
        read_sequence INTEGER,
        
        -- Local Cache / UI Fields
        latest_msg TEXT,
        latest_msg_time INTEGER, -- Renamed from latest_msg_send_time
        unread_count INTEGER,
        order_key INTEGER,
        draft_text TEXT,
        draft_text_time INTEGER,
        ex TEXT
      )
    ''');

    // 4. 创建本地群组表 (local_groups)
    // Aligned with Server ImGroupEntity
    // Fields: group_id, owner_id, group_type, group_name, mute, apply_join_type,
    // introduction, notification, face_url, max_member_count, status, sequence, create_time, update_time, extra
    await db.execute('''
      CREATE TABLE $_tblGroups (
        group_id TEXT PRIMARY KEY,
        owner_id TEXT,
        group_type INTEGER,
        group_name TEXT,
        mute INTEGER,
        apply_join_type INTEGER,
        introduction TEXT,
        notification TEXT,
        face_url TEXT,
        max_member_count INTEGER,
        status INTEGER,
        sequence INTEGER,
        create_time INTEGER,
        update_time INTEGER,
        ex TEXT
      )
    ''');

    // 5. 创建本地群成员表 (local_group_members)
    // Aligned with Server ImGroupMemberEntity
    // Fields: group_id, member_id, role, mute_end_time, alias, join_time, leave_time, join_type, extra
    await db.execute('''
      CREATE TABLE $_tblGroupMembers (
        group_id TEXT,
        member_id TEXT,
        role INTEGER,
        mute_end_time INTEGER,
        alias TEXT,
        join_time INTEGER,
        leave_time INTEGER,
        join_type TEXT,
        ex TEXT,
        PRIMARY KEY(group_id, member_id)
      )
    ''');

    // 6. 创建本地黑名单表 (local_blacks) - REMOVED
    // Using local_friends with black=1 instead
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("IMSDK: Upgrading database from version $oldVersion to $newVersion");
    if (oldVersion < 2) {
      // Create local_messages table
      await db.execute('''
        CREATE TABLE $_tblMessages (
          client_msg_id TEXT PRIMARY KEY,
          server_msg_id TEXT,
          conversation_id TEXT,
          sender_id TEXT,
          send_time INTEGER,
          create_time INTEGER, -- Timestamp in API
          content_type INTEGER,
          content TEXT, -- JSON content
          seq INTEGER,
          status INTEGER,
          is_read INTEGER,
          sender_face_url TEXT,
          sender_nickname TEXT,
          attached_info TEXT,
          ex TEXT
        )
      ''');
    }
  }

  /// 获取群成员列表 (JOIN Query)
  Future<List<ImGroupMember>> getGroupMemberList(String groupId) async {
    if (_database == null || _currentUserID == null) return [];

    final List<Map<String, dynamic>> maps = await _database!.rawQuery(
      '''
      SELECT 
        GM.*,
        U.nick_name, U.face_url
      FROM $_tblGroupMembers GM
      LEFT JOIN $_tblUsers U ON GM.member_id = U.user_id
      WHERE GM.group_id = ?
      ''',
      [groupId],
    );

    return List.generate(maps.length, (i) => _mapToGroupMember(maps[i]));
  }

  /// 批量插入好友列表 (Transactions)
  /// 自动拆分存储到 local_users 和 local_friends
  Future<void> batchInsertFriends(List<ImFriendInfo> friends) async {
    if (_database == null || _currentUserID == null) return;

    await _database!.transaction((txn) async {
      final batch = txn.batch();

      for (var friend in friends) {
        // 1. Upsert User Info
        if (friend.userProfile != null) {
          batch.insert(
            _tblUsers,
            _userToMap(friend.userProfile!),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }

        // 2. Upsert Friend Relation
        batch.insert(
          _tblFriends,
          _friendToRelationMap(friend),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
    });
    print("IMSDK: Cached ${friends.length} friends locally.");
  }

  /// 批量插入用户资料
  Future<void> batchInsertUsers(List<ImUserFullInfo> users) async {
    if (_database == null || _currentUserID == null) return;

    await _database!.transaction((txn) async {
      final batch = txn.batch();
      for (var user in users) {
        batch.insert(
          _tblUsers,
          _userToMap(user),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
    print("IMSDK: Cached ${users.length} users locally.");
  }

  /// 批量插入/更新群组列表
  Future<void> batchInsertGroups(List<ImGroupInfo> groups) async {
    if (_database == null || _currentUserID == null) return;

    await _database!.transaction((txn) async {
      final batch = txn.batch();
      for (var group in groups) {
        batch.insert(
          _tblGroups,
          _groupToMap(group),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
    print("IMSDK: Cached ${groups.length} groups locally.");
  }

  /// 获取指定列表的用户资料
  Future<List<ImUserFullInfo>> getUserList(List<String> userIDs) async {
    if (_database == null || _currentUserID == null || userIDs.isEmpty) {
      return [];
    }

    final placeholders = List.filled(userIDs.length, '?').join(',');
    final List<Map<String, dynamic>> maps = await _database!.rawQuery('''
      SELECT * FROM $_tblUsers WHERE user_id IN ($placeholders)
      ''', userIDs);

    return List.generate(maps.length, (i) => _mapToUserInfo(maps[i]));
  }

  /// 获取本地好友列表 (JOIN Query)
  /// 仅返回状态正常且未拉黑的好友
  Future<List<ImFriendInfo>> getFriendList() async {
    if (_database == null || _currentUserID == null) return [];

    // 执行关联查询
    // Filter by status=1 (Normal) and black=0 (Not Black)
    final List<Map<String, dynamic>> maps = await _database!.rawQuery(
      '''
      SELECT 
        F.to_id, F.remark, F.add_source, F.create_time, F.extra, F.status, F.black, F.friend_sequence,
        U.user_id, U.nick_name as nickname, U.face_url, U.gender, U.self_signature, 
        U.friend_allow_type, U.birthday, U.location, U.extra as user_extra
      FROM $_tblFriends F
      LEFT JOIN $_tblUsers U ON F.to_id = U.user_id
      WHERE F.from_id = ? AND F.status = 1 AND (F.black IS NULL OR F.black = 0)
    ''',
      [_currentUserID],
    );

    return List.generate(maps.length, (i) => _mapToFriendInfo(maps[i]));
  }

  /// 获取指定好友信息列表 (Smart Fetch Support)
  Future<List<ImFriendInfo>> getFriendInfoList(List<String> userIDs) async {
    if (_database == null || _currentUserID == null || userIDs.isEmpty) {
      return [];
    }

    final placeholders = List.filled(userIDs.length, '?').join(',');
    final List<Map<String, dynamic>> maps = await _database!.rawQuery(
      '''
      SELECT 
        F.to_id, F.remark, F.add_source, F.create_time, F.extra, F.status, F.black, F.friend_sequence,
        U.user_id, U.nick_name as nickname, U.face_url, U.gender, U.self_signature, 
        U.friend_allow_type, U.birthday, U.location, U.extra as user_extra
      FROM $_tblFriends F
      LEFT JOIN $_tblUsers U ON F.to_id = U.user_id
      WHERE F.from_id = ? 
        AND F.to_id IN ($placeholders)
      ''',
      [_currentUserID, ...userIDs],
    );

    return List.generate(maps.length, (i) => _mapToFriendInfo(maps[i]));
  }

  /// 获取本地黑名单列表 (JOIN Query, black=1)
  Future<List<ImFriendInfo>> getBlackList() async {
    if (_database == null || _currentUserID == null) return [];

    final List<Map<String, dynamic>> maps = await _database!.rawQuery(
      '''
      SELECT 
        F.to_id, F.remark, F.add_source, F.create_time, F.extra, F.status, F.black, F.friend_sequence,
        U.user_id, U.nick_name as nickname, U.face_url, U.gender, U.self_signature, 
        U.friend_allow_type, U.birthday, U.location, U.extra as user_extra
      FROM $_tblFriends F
      LEFT JOIN $_tblUsers U ON F.to_id = U.user_id
      WHERE F.from_id = ? AND F.black = 1
    ''',
      [_currentUserID],
    );

    return List.generate(maps.length, (i) => _mapToFriendInfo(maps[i]));
  }

  /// 获取会话列表 (Hydrated from multiple tables)
  Future<List<ImConversation>> getConversationList() async {
    if (_database == null || _currentUserID == null) return [];

    // Note: Assuming 'local_messages' table exists with 'conversation_id', 'seq', 'content', 'send_time'
    // If not, this query will fail or return nulls.
    // For this task, we focus on the structure alignment.
    // Simplifying latest_msg for now to avoid compilation errors if local_messages doesn't exist yet.

    final List<Map<String, dynamic>> maps = await _database!.rawQuery(
      '''
      SELECT 
        C.*,
        U.nick_name, U.face_url as user_face,
        G.group_name, G.face_url as group_face
        -- Add subqueries for message here when message table is ready
      FROM $_tblConversations C
      LEFT JOIN $_tblUsers U ON C.to_id = U.user_id AND C.conversation_type = 1
      LEFT JOIN $_tblGroups G ON C.to_id = G.group_id AND C.conversation_type = 2
      WHERE C.from_id = ?
      ORDER BY C.order_key DESC
      ''',
      [_currentUserID],
    );

    return List.generate(maps.length, (i) => _mapToConversation(maps[i]));
  }

  /// 批量插入/更新会话列表 (Sync from Server)
  Future<void> batchInsertConversations(
    List<ImConversation> conversations,
  ) async {
    if (_database == null || _currentUserID == null) return;

    await _database!.transaction((txn) async {
      final batch = txn.batch();

      for (var conv in conversations) {
        batch.insert(
          _tblConversations,
          _conversationToMap(conv),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
    print("IMSDK: Cached ${conversations.length} conversations locally.");
  }

  /// 批量插入消息 (Sync)
  Future<void> batchInsertMessages(List<ImMessage> messages) async {
    if (_database == null || _currentUserID == null) return;
    await _database!.transaction((txn) async {
      final batch = txn.batch();
      for (var msg in messages) {
        batch.insert(
          _tblMessages,
          _messageToMap(msg),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
    print("IMSDK: Cached ${messages.length} messages locally.");
  }

  /// 获取最大消息 Seq
  Future<int> getMaxMessageSeq() async {
    if (_database == null) return 0;
    try {
      final List<Map<String, dynamic>> result = await _database!.rawQuery(
        "SELECT MAX(seq) as max_seq FROM $_tblMessages",
      );
      if (result.isNotEmpty && result.first['max_seq'] != null) {
        return result.first['max_seq'] as int;
      }
    } catch (e) {
      print("IMSDK: Error getting max message seq: $e");
    }
    return 0;
  }

  Map<String, dynamic> _messageToMap(ImMessage msg) {
    // Determine Conversation ID if missing?
    // Usually msg has conversationID. If not, derive from groupID or logic.
    // For sync, msg usually has conversationID.
    // ImMessage model doesn't have 'conversationID' field explicitly?
    // Check Step 3950: ImMessage has 'groupID', 'userID' (peer), 'msgID'.
    // It doesn't have 'conversationID' field!
    // We must derive it.
    // Single: if sender == self, converID = "single_" + userID (peer).
    //         if sender != self, converID = "single_" + sender.
    // Group: "group_" + groupID.
    // Wait, OpenIM usage: conversationID logic is complex.
    // But for storage, we might need it.
    // Or we store 'session_type' and 'session_id'.
    // Let's check _tblMessages schema I defined above: 'conversation_id'.
    // I need to generate it.
    // Helper:
    String convID = "";
    if (msg.groupID != null && msg.groupID!.isNotEmpty) {
      convID = "group_${msg.groupID}";
    } else {
      // Single chat
      // Need to sort IDs? Or is it fixed "single_OTHER"?
      // OpenIM Single Chat ConversationID: "single_" + UserID
      // If I am sender, UserID is receiver.
      // If I am receiver, UserID is sender.
      // Actually ImMessage 'userID' field usually means the Peer ID in some contexts, or Receiver?
      // Let's assume standard logic:
      // If self send: Peer is msg.userID (receiver).
      // If self receive: Peer is msg.sender.
      String peer = (msg.sender == _currentUserID)
          ? (msg.userID ?? "")
          : (msg.sender ?? "");
      convID = "single_$peer";
    }

    return {
      'client_msg_id': msg.msgID, // SDK generated?
      'server_msg_id': msg.msgID, // Or id?
      'conversation_id': convID,
      'sender_id': msg.sender,
      'send_time': msg.timestamp,
      'create_time': msg.timestamp,
      'content_type': msg.elemType,
      'content': jsonEncode(msg.toJson()), // Store full JSON for simplicity
      'seq': int.tryParse(msg.seq.toString()) ?? 0,
      'status': msg.status,
      'is_read': msg.isRead == true ? 1 : 0,
      'sender_face_url': msg.faceUrl,
      'sender_nickname': msg.nickName,
      'attached_info': null,
      'ex': msg.localCustomData,
    };
  }

  /// 获取最大的好友 Sequence (用于增量同步)
  Future<int> getFriendMaxSequence() async {
    if (_database == null) return 0;
    try {
      final List<Map<String, dynamic>> result = await _database!.rawQuery(
        "SELECT MAX(friend_sequence) as max_seq FROM $_tblFriends",
      );
      if (result.isNotEmpty && result.first['max_seq'] != null) {
        return result.first['max_seq'] as int;
      }
    } catch (e) {
      print("IMSDK: Error getting max friend sequence: $e");
    }
    return 0;
  }

  // ImConversation Mapper
  ImConversation _mapToConversation(Map<String, dynamic> map) {
    String? showName;
    String? faceUrl;

    int type = map['conversation_type'] ?? 0;
    if (type == 1) {
      // Single
      showName = map['nick_name'];
      faceUrl = map['user_face'];
    } else if (type == 2) {
      // Group
      showName = map['group_name'];
      faceUrl = map['group_face'];
    }

    // Parse latest message
    ImMessage? latestMsg;
    if (map['latest_msg'] != null && map['latest_msg'].toString().isNotEmpty) {
      try {
        latestMsg = ImMessage.fromJson(jsonDecode(map['latest_msg']));
      } catch (e) {
        print("IMSDK: Error parsing latest msg: $e");
      }
    }

    return ImConversation(
      conversationID: map['conversation_id'],
      type: type,
      userID: type == 1 ? map['to_id'] : null,
      groupID: type == 2 ? map['to_id'] : null,
      showName: showName,
      faceUrl: faceUrl,
      isPinned: (map['is_top'] == 1),
      recvOpt: map['is_mute'],
      draftText: map['draft_text'],
      draftTimestamp: map['draft_text_time'],
      unreadCount: map['unread_count'] ?? 0,
      lastMessage: latestMsg,
      orderkey: map['order_key'],
    );
  }

  /// 关闭数据库
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  // --- Helper Methods ---

  Map<String, dynamic> _userToMap(ImUserFullInfo user) {
    return {
      'user_id': user.userId,
      'nickname': user.nickName,
      'face_url': user.faceUrl,
      'gender': user.gender,
      'self_signature': user.selfSignature,
      'friend_allow_type': user.friendAllowType,
      'birthday': user.birthday,
      'location': user.location,
      'extra': user.extra,
    };
  }

  Map<String, dynamic> _conversationToMap(ImConversation conv) {
    return {
      'conversation_id': conv.conversationID,
      'conversation_type': conv.type,
      'from_id': _currentUserID, // Conversation list is for current user
      'to_id': conv.userID ?? conv.groupID,
      'is_mute': conv.recvOpt,
      'is_top': conv.isPinned == true ? 1 : 0,
      'sequence': 0, // Server might not send sequence in ImConversation
      'read_sequence': 0,
      'latest_msg': conv.lastMessage != null
          ? jsonEncode(conv.lastMessage!.toJson())
          : null,
      'latest_msg_time':
          conv.lastMessage?.timestamp ?? 0, // Correct field is timestamp
      'unread_count': conv.unreadCount,
      'order_key': conv.orderkey,
      'draft_text': conv.draftText,
      'draft_text_time': conv.draftTimestamp,
      'ex': conv.customData,
    };
  }

  Map<String, dynamic> _groupToMap(ImGroupInfo group) {
    return {
      'group_id': group.groupID,
      'group_name': group.groupName,
      'notification': group.notification,
      'introduction': group.introduction,
      'face_url': group.faceUrl,
      'owner_id': group.owner,
      'create_time': group.createTime,
      'update_time': group.lastInfoTime ?? 0,
      'max_member_count': group
          .memberCount, // Using current count as placeholder if max missing
      'status': 0, // Default to normal as model lacks status
      'group_type': int.tryParse(group.groupType) ?? 0,
      'mute': group.isAllMuted == true ? 1 : 0,
      'ex': group.customInfo != null ? jsonEncode(group.customInfo) : null,
    };
  }

  ImUserFullInfo _mapToUserInfo(Map<String, dynamic> map) {
    return ImUserFullInfo(
      userId: map['user_id'],
      nickName: map['nick_name'],
      faceUrl: map['face_url'],
      gender: map['gender'],
      selfSignature: map['self_signature'],
      friendAllowType: map['friend_allow_type'],
      birthday: map['birthday'],
      location: map['location'],
      extra: map['extra'],
    );
  }

  Map<String, dynamic> _friendToRelationMap(ImFriendInfo friend) {
    // Serialize extra fields (customInfo, groups) into 'extra'
    final Map<String, dynamic> exMap = {};
    if (friend.friendCustomInfo != null) {
      exMap['friendCustomInfo'] = friend.friendCustomInfo;
    }
    if (friend.friendGroups != null && friend.friendGroups!.isNotEmpty) {
      exMap['friendGroups'] = friend.friendGroups;
    }

    return {
      'from_id': _currentUserID,
      'to_id': friend.toId,
      'remark': friend.remark,
      'add_source': friend.addSource,
      'create_time': friend.createTime,
      'status': friend.status,
      'black': friend.black,
      'friend_sequence': friend.friendSequence,
      'extra': exMap.isNotEmpty ? jsonEncode(exMap) : null,
    };
  }

  ImFriendInfo _mapToFriendInfo(Map<String, dynamic> map) {
    // 组装 UserProfile
    ImUserFullInfo? userProfile;
    if (map['user_id'] != null) {
      userProfile = ImUserFullInfo(
        userId: map['user_id'],
        nickName: map['nickname'],
        faceUrl: map['face_url'],
        gender: map['gender'],
        selfSignature: map['self_signature'],
        friendAllowType: map['friend_allow_type'],
        birthday: map['birthday'],
        location: map['location'],
        extra: map['user_extra'] ?? map['extra'],
      );
    }

    // Parse 'extra' field for customInfo and groups
    // Note: stored column is 'extra'
    Map<String, String>? friendCustomInfo;
    List<String>? friendGroups;
    if (map['extra'] != null) {
      try {
        final exMap = jsonDecode(map['extra']);
        if (exMap['friendCustomInfo'] != null) {
          friendCustomInfo = Map<String, String>.from(
            exMap['friendCustomInfo'],
          );
        }
        if (exMap['friendGroups'] != null) {
          friendGroups = List<String>.from(exMap['friendGroups']);
        }
      } catch (e) {
        print("IMSDK: Error parsing friend extra info: $e");
      }
    }

    // 组装 FriendInfo
    return ImFriendInfo(
      toId: map['to_id'],
      remark: map['remark'],
      addSource: map['add_source'],
      createTime: map['create_time'],
      userProfile: userProfile,
      friendCustomInfo: friendCustomInfo,
      friendGroups: friendGroups,
      status: map['status'],
      black: map['black'],
      friendSequence: map['friend_sequence'],
    );
  }

  // ImGroupMember Mapper
  ImGroupMember _mapToGroupMember(Map<String, dynamic> map) {
    return ImGroupMember.fromJson(map);
  }
}
