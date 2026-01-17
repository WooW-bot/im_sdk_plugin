# OpenIM vs 腾讯云 IM (TIM) Flutter SDK API 对比

本文档主要按功能模块，详细对比了 OpenIM 和腾讯云 IM (TIM) 的 Flutter SDK API。

> **说明**:
> - **OpenIM SDK**: 通过 `OpenIM.iMManager` 调用 (例如 `OpenIM.iMManager.login`)。
> - **TIM SDK**: 通过 `TencentImSDKPlugin.v2TIMManager` 调用 (例如 `TencentImSDKPlugin.v2TIMManager.login`)。

## 1. 初始化与登录 (Initialization & Login)

| 功能 (Feature) | OpenIM API (`OpenIM.iMManager`) | Tencent Cloud IM API (`v2TIMManager`) | 备注 (Notes) |
| :--- | :--- | :--- | :--- |
| **初始化 SDK** | `initSDK(...)` | `initSDK(...)` | 两者都需要 SDK AppID/Platform ID。 |
| **登录** | `login(...)` | `login(...)` | 两者都需要 UserID 和 Token (UserSig)。 |
| **登出** | `logout()` | `logout()` | |
| **获取登录状态** | `getLoginStatus()` | `getLoginStatus()` | |
| **获取登录用户** | `getLoginUserID()`, `getLoginUserInfo()` | `getLoginUser()` | |
| **设置个人资料** | `userManager.setSelfInfo(...)` | `setSelfInfo(...)` (直接通过 `v2TIMManager` 或 `initSDKListener`) | |

## 2. 会话管理 (Conversation Management)

| 功能 (Feature) | OpenIM API (`conversationManager`) | TIM API (`v2ConversationManager`) | 备注 (Notes) |
| :--- | :--- | :--- | :--- |
| **获取会话列表** | `getAllConversationList()`, `getConversationListSplit(...)` | `getConversationList(...)` | TIM 使用 `nextSeq` 分页；OpenIM 支持全量和分页。 |
| **获取单个会话** | `getOneConversation(...)` | `getConversation(...)` | |
| **会话置顶** | `pinConversation(...)` | `pinConversation(...)` | |
| **删除会话** | `deleteConversationAndDeleteAllMsg(...)` | `deleteConversation(...)` | |
| **设置草稿** | `setConversationDraft(...)` | `setConversationDraft(...)` | |
| **未读消息总数** | `getTotalUnreadMsgCount()` | `getTotalUnreadMessageCount()` | |
| **标记已读** | `markConversationMessageAsRead(...)` | (见消息管理) | TIM 通常通过消息管理器或特定会话方法标记已读。 |
| **监听器** | `setConversationListener(...)` | `setConversationListener(...)` | |

## 3. 关系链管理 (Friendship Management)

| 功能 (Feature) | OpenIM API (`friendshipManager`) | TIM API (`v2TIMFriendshipManager`) | 备注 (Notes) |
| :--- | :--- | :--- | :--- |
| **获取好友列表** | `getFriendList()`, `getFriendListPage(...)` | `getFriendList()` | |
| **获取好友资料** | `getFriendsInfo(...)` | `getFriendsInfo(...)` | |
| **添加好友** | `addFriend(...)` | `addFriend(...)` | |
| **删除好友** | `deleteFriend(...)` | `deleteFromFriendList(...)` | TIM 允许指定删除类型（单向/双向）。 |
| **好友信息设置** | `setFriendRemark(...)` (已废弃), `updateFriends(...)` | `setFriendInfo(...)` | |
| **检查好友关系** | `checkFriend(...)` | `checkFriend(...)` | |
| **好友申请列表** | `getFriendApplicationListAsRecipient(...)`, `getFriendApplicationListAsApplicant(...)` | `getFriendApplicationList()` | OpenIM 将申请者/接收者列表分开。 |
| **处理好友申请** | `acceptFriendApplication(...)`, `refuseFriendApplication(...)` | `acceptFriendApplication(...)`, `refuseFriendApplication(...)` | |
| **黑名单管理** | `addBlacklist(...)`, `removeBlacklist(...)`, `getBlacklist(...)` | `addToBlackList(...)`, `deleteFromBlackList(...)`, `getBlackList(...)` | |
| **好友分组** | (在 `getFriendGroupList` 中有基础支持) | `createFriendGroup`, `getFriendGroups`, `deleteFriendGroup`, `addFriendsToFriendGroup` 等 | TIM 拥有更丰富的好友分组 API。 |

## 4. 群组管理 (Group Management)

| 功能 (Feature) | OpenIM API (`groupManager`) | TIM API (`v2TIMGroupManager`) | 备注 (Notes) |
| :--- | :--- | :--- | :--- |
| **创建群组** | `createGroup(...)` | `createGroup(...)` | |
| **加入群组** | `joinGroup(...)` | `joinGroup(...)` | |
| **退出群组** | `quitGroup(...)` | `quitGroup(...)` | |
| **解散群组** | `dismissGroup(...)` | `dismissGroup(...)` | |
| **已加入群组列表** | `getJoinedGroupList()` | `getJoinedGroupList()` | |
| **获取群资料** | `getGroupsInfo(...)` | `getGroupsInfo(...)` | |
| **修改群资料** | `setGroupInfo(...)` | `setGroupInfo(...)` | |
| **获取成员列表** | `getGroupMemberList(...)` | `getGroupMemberList(...)` | |
| **踢出成员** | `kickGroupMember(...)` | `kickGroupMember(...)` | |
| **邀请成员** | `inviteUserToGroup(...)` | `inviteUserToGroup(...)` | |
| **禁言成员** | `changeGroupMemberMute(...)` | `muteGroupMember(...)` | |
| **转让群主** | `transferGroupOwner(...)` | `transferGroupOwner(...)` | |
| **群申请列表** | `getGroupApplicationListAsRecipient(...)`, `getGroupApplicationListAsApplicant(...)` | `getGroupApplicationList()` | OpenIM 将申请者/接收者列表分开。 |
| **处理群申请** | `acceptGroupApplication(...)`, `refuseGroupApplication(...)` | `acceptGroupApplication(...)`, `refuseGroupApplication(...)` | |

## 5. 消息管理 (Message Management)

这是 API 设计差异最大的部分。

| 功能 (Feature) | OpenIM API (`messageManager`) | TIM API (`v2TIMManager` / `v2TIMMessageManager`) | 备注 (Notes) |
| :--- | :--- | :--- | :--- |
| **发送文本** | 1. `createTextMessage(...)`<br>2. `sendMessage(...)` | `sendC2CTextMessage` / `sendGroupTextMessage` (简易)<br>或 `createTextMessage` + `sendMessage` (高级) | TIM 提供快捷方式。OpenIM 严格执行“两步走”。 |
| **发送图片** | `createImageMessage(...)` + `sendMessage` | `createImageMessage` + `sendMessage` | |
| **发送视频** | `createVideoMessage(...)` + `sendMessage` | `createVideoMessage` + `sendMessage` | |
| **发送音频** | `createSoundMessage(...)` + `sendMessage` | `createSoundMessage` + `sendMessage` | |
| **发送自定义消息** | `createCustomMessage(...)` + `sendMessage` | `sendC2CCustomMessage` / `sendGroupCustomMessage`<br>或 `createCustomMessage` + `sendMessage` | |
| **撤回消息** | `revokeMessage(...)` | `revokeMessage(...)` | |
| **删除消息** | `deleteMessageFromLocalStorage(...)` | `deleteMessageFromLocalStorage(...)`, `deleteMessages(...)` | |
| **历史消息 (高级)** | `getAdvancedHistoryMessageList(...)` | `getHistoryMessageList(...)` | |
| **搜索消息** | `searchLocalMessages(...)` | `searchLocalMessages(...)` | |
| **输入状态** | `changeInputStates(...)` (在 conversationManager 中) | (通常通过 C2C 自定义消息处理) | |
