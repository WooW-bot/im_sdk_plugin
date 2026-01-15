# im_sdk_plugin

**im_sdk_plugin** 是一个提供全面即时通讯 (IM) 能力的 Flutter 插件。它封装了原生的 IM 功能，并为 Flutter 应用暴露了统一的 Dart API，使开发者能够轻松集成聊天、群组管理和社交网络功能。

## 功能特性

本 SDK 被组织成多个管理器，每个管理器负责特定的功能集：

### 1. 核心管理器 (`IMManager`)
- **初始化**：使用 AppID 和配置项初始化 SDK。
- **认证**：用户登录和登出。
- **用户信息**：获取和更新个人及其他用户的资料/状态。
- **通用**：获取 SDK 版本、服务器时间、登录状态。

### 2. 会话管理器 (`IMConversationManager`)
- **会话列表**：获取支持分页的本地会话历史。
- **管理**：置顶、删除会话，设置草稿。
- **未读计数**：获取总未读消息数。

### 3. 关系链管理器 (`IMFriendshipManager`)
- **好友管理**：添加、删除、检查好友。
- **好友列表**：获取好友列表和好友资料。
- **黑名单**：管理黑名单用户。
- **好友申请**：处理入站的好友请求（同意/拒绝）。

### 4. 群组管理器 (`IMGroupManager`)
- **群组管理**：创建、加入、退出和解散群组。
- **群组信息**：获取和设置群组资料及属性。
- **成员管理**：管理群成员（踢出、禁言、修改角色）。
- **群组申请**：处理入群请求。

### 5. 消息管理器 (`IMMessageManager`)
- **发送消息**：支持文本、图片、视频、语音、文件、位置、表情、自定义和合并消息。
- **消息历史**：拉取 C2C（单聊）和群组消息历史。
- **消息控制**：撤回、删除和修改消息。
- **扩展**：支持消息已读回执等高级功能。

### 6. 离线推送管理器 (`IMOfflinePushManager`)
- **推送配置**：设置离线推送 Token (APNS/FCM)。
- **角标管理**：处理后台/前台状态下的应用角标计数。

### 7. 信令管理器 (`IMSignalingManager`)
- **信令操作**：邀请、邀请加入群组、取消、接受、拒绝邀请。
- **信令监听**：添加和移除信令监听器。

---

## 开发计划

我们正遵循分阶段的方法来构建此插件：

- [x] **阶段 1：接口设计**
    - 定义所有模型类 (`lib/models/`)。
    - 定义所有枚举类及监听器 (`lib/enums/`, `lib/listener/`)。
    - 定义抽象管理器类 (`lib/manager/`)。
    - 为公共 API 添加文档注释。

- [ ] **阶段 2：平台通道实现**
    - [x] 在 Dart 管理器中实现 `MethodChannel` 逻辑 (已完成接口定义和存根)。
    - [x] 实现 Dart 侧 `initSDK` 核心逻辑（本地初始化配置、日志、DB预备）。
    - [ ] 完善 `login` 逻辑（网络路由与 TCP 连接）。
    - [ ] 处理方法调用和事件流。
    - [ ] 实现 Dart 模型与 JSON 之间的映射，用于平台通信。

- [ ] **阶段 3：原生实现 (Android/iOS)**
    - [ ] 实现 Android 原生封装 (Java/Kotlin)。
    - [ ] 实现 iOS 原生封装 (Objective-C/Swift)。
    - [ ] 集成底层原生 IM SDK。

- [ ] **阶段 4：测试与打磨**
    - [ ] Dart 模型和逻辑的单元测试。
    - [x] 使用 `example` 应用进行集成测试 (已完善示例应用结构)。
    - [x] 完善文档和示例 (API 文档注释已全覆盖)。

## 示例应用 (Example App)

本项目包含一个完整的示例应用程序，位于 `example` 目录下。该应用展示了如何集成和使用 SDK 的各项核心功能：

- **登录与用户管理**：模拟用户登录和资料展示。
- **会话列表**：展示最近的聊天会话。
- **消息发送与接收**：支持发送文本、图片、语音、视频等多种消息类型。
- **群组管理**：演示群组创建、成员管理等操作。

运行示例应用：

```bash
cd example
flutter pub get
flutter run
```


## 使用指南

### 1. 初始化 SDK

在调用任何其他接口之前，必须先初始化 SDK。`initSDK` 方法负责加载配置、初始化日志系统和准备本地数据库。

```dart
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/enums/log_level_enum.dart';
import 'package:im_sdk_plugin/listener/im_sdk_listener.dart';

// 定义 SDK 监听器
final listener = ImSDKListener(
  onConnectSuccess: () {
    print("连接成功");
  },
  onConnecting: () {
    print("连接中...");
  },
  onConnectFailed: (code, error) {
    print("连接失败: $code - $error");
  },
  onKickedOffline: () {
    print("被踢下线");
  },
  onUserSigExpired: () {
    print("UserSig 过期");
  },
);

// 调用初始化
ImValueCallback<bool> res = await ImSDKPlugin.imManager.initSDK(
  appID: 1234567890, // 您的 SDK AppID
  logLevel: LogLevelEnum.IM_LOG_ALL, // 日志等级
  showImLog: true, // 是否在控制台输出日志
  listener: listener, // 传入监听器
);

if (res.code == 0) {
  print("初始化成功");
} else {
  print("初始化失败: ${res.desc}");
}
```

**注意**：`initSDK` 仅进行本地环境初始化。实际的网络连接（TCP/WebSocket）将在调用 `login` 成功获取服务器路由后自动建立。

## 快速开始

本项目是 Flutter [插件包](https://flutter.dev/to/develop-plugins) 的起点，插件包是一种包含 Android 和/或 iOS 平台特定实现代码的专用包。

如需获得 Flutter 开发入门方面的帮助，请查看 [在线文档](https://docs.flutter.dev)，其中提供了教程、示例、移动开发指南以及完整的 API 参考。

## API 接口实现状态 (API Implementation Status)

**总体进度**: 6 / 160 (3.75%)

### 1. IMManager (6/30)
- [x] initSDK
- [ ] unInitSDK
- [x] login
- [x] logout
- [x] getLoginUser
- [x] getLoginStatus
- [ ] getServerTime
- [ ] getVersion
- [ ] getConversationManager
- [ ] getFriendshipManager
- [ ] getGroupManager
- [ ] getMessageManager
- [ ] getOfflinePushManager
- [ ] addGroupListener
- [ ] removeGroupListener
- [ ] joinGroup
- [ ] quitGroup
- [ ] dismissGroup
- [x] getUsersInfo
- [ ] getUserStatus
- [ ] setSelfInfo
- [ ] setSelfStatus
- [ ] setAPNSListener
- [ ] callExperimentalAPI
- [ ] sendC2CTextMessage
- [ ] sendGroupTextMessage
- [ ] getSignalingManager
- [ ] checkAbility
- [ ] removeSimpleMsgListener
- [ ] addSimpleMsgListener

### 2. IMConversationManager (0/18)
- [ ] addConversationListener
- [ ] removeConversationListener
- [ ] getConversationList
- [ ] getConversationListByConversationIds
- [ ] pinConversation
- [ ] getTotalUnreadMessageCount
- [ ] getConversation
- [ ] deleteConversation
- [ ] setConversationDraft
- [ ] createConversationGroup
- [ ] renameConversationGroup
- [ ] getConversationGroupList
- [ ] addConversationsToGroup
- [ ] deleteConversationsFromGroup
- [ ] deleteConversationGroup
- [ ] setConversationCustomData
- [ ] markConversation
- [ ] getConversationListByFilter

### 3. IMFriendshipManager (0/23)
- [ ] addToBlackList
- [ ] deleteFromBlackList
- [ ] getBlackList
- [ ] addFriendListener
- [ ] removeFriendListener
- [ ] getFriendList
- [ ] getFriendsInfo
- [ ] setFriendInfo
- [ ] addFriend
- [ ] deleteFromFriendList
- [ ] checkFriend
- [ ] getFriendApplicationList
- [ ] acceptFriendApplication
- [ ] refuseFriendApplication
- [ ] deleteFriendApplication
- [ ] setFriendApplicationRead
- [ ] createFriendGroup
- [ ] getFriendGroups
- [ ] deleteFriendGroup
- [ ] renameFriendGroup
- [ ] addFriendsToFriendGroup
- [ ] deleteFriendsFromFriendGroup
- [ ] searchFriends

### 4. IMGroupManager (0/26)
- [ ] createGroup
- [ ] getJoinedGroupList
- [ ] getGroupsInfo
- [ ] setGroupInfo
- [ ] deleteGroupAttributes
- [ ] getGroupAttributes
- [ ] searchGroups
- [ ] getGroupOnlineMemberCount
- [ ] getGroupMemberList
- [ ] getGroupMembersInfo
- [ ] setGroupMemberInfo
- [ ] searchGroupMembers
- [ ] muteGroupMember
- [ ] kickGroupMember
- [ ] setGroupMemberRole
- [ ] transferGroupOwner
- [ ] inviteUserToGroup
- [ ] getGroupApplicationList
- [ ] acceptGroupApplication
- [ ] refuseGroupApplication
- [ ] setGroupApplicationRead
- [ ] getJoinedCommunityList
- [ ] createTopicInCommunity
- [ ] deleteTopicFromCommunity
- [ ] setTopicInfo
- [ ] getTopicInfoList

### 5. IMMessageManager (0/51)
- [ ] createTextMessage
- [ ] createCustomMessage
- [ ] createImageMessage
- [ ] createSoundMessage
- [ ] createVideoMessage
- [ ] createTextAtMessage
- [ ] createFileMessage
- [ ] createLocationMessage
- [ ] createFaceMessage
- [ ] createMergerMessage
- [ ] createForwardMessage
- [ ] createTargetedGroupMessage
- [ ] appendMessage
- [ ] addAdvancedMsgListener
- [ ] removeAdvancedMsgListener
- [ ] getC2CHistoryMessageList
- [ ] getHistoryMessageList
- [ ] getGroupHistoryMessageList
- [ ] markC2CMessageAsRead
- [ ] markGroupMessageAsRead
- [ ] markAllMessageAsRead
- [ ] deleteMessageFromLocalStorage
- [ ] deleteMessages
- [ ] insertGroupMessageToLocalStorage
- [ ] insertC2CMessageToLocalStorage
- [ ] clearC2CHistoryMessage
- [ ] clearGroupHistoryMessage
- [ ] downloadMergerMessage
- [ ] setC2CReceiveMessageOpt
- [ ] setGroupReceiveMessageOpt
- [ ] setLocalCustomData
- [ ] setLocalCustomInt
- [ ] revokeMessage
- [ ] modifyMessage
- [ ] sendMessage
- [ ] searchLocalMessages
- [ ] sendMessageReadReceipts
- [ ] getMessageReadReceipts
- [ ] getGroupMessageReadMemberList
- [ ] downloadMessage
- [ ] getMessageOnlineUrl
- [ ] setMessageExtensions
- [ ] getMessageExtensions
- [ ] deleteMessageExtensions
- [ ] setCloudCustomData
- [ ] findMessages
- [ ] getC2CReceiveMessageOpt
- [ ] reSendMessage
- [ ] sendCustomMessage
- [ ] getHistoryMessageListV2
- [ ] getHistoryMessageListWithoutFormat

### 6. IMOfflinePushManager (0/3)
- [ ] doBackground
- [ ] doForeground
- [ ] setOfflinePushConfig

### 7. IMSignalingManager (0/9)
- [ ] addSignalingListener
- [ ] removeSignalingListener
- [ ] invite
- [ ] inviteInGroup
- [ ] cancel
- [ ] accept
- [ ] reject
- [ ] addInvitedSignaling
- [ ] getSignalingInfo

