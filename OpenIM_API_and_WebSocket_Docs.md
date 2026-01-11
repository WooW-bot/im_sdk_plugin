# OpenIM SDK HTTP API & WebSocket Event Documentation

本文档详细整理了 OpenIM SDK 中所有的 HTTP 请求（包含请求/响应参数）以及 WebSocket 事件通知（触发场景及参数详情）。

---

## 目录

1.  [HTTP 请求 (REST API)](#1-http-请求-rest-api)
    *   [用户管理 (User)](#11-用户管理-user)
    *   [好友关系 (Friend)](#12-好友关系-friend)
    *   [群组管理 (Group)](#13-群组管理-group)
    *   [消息管理 (Message)](#14-消息管理-message)
    *   [会话管理 (Conversation)](#15-会话管理-conversation)
2.  [WebSocket 事件通知 (Push Events)](#2-websocket-事件通知-push-events)
    *   [好友相关通知 (Friend)](#21-好友相关通知-friend)
    *   [群组相关通知 (Group)](#22-群组相关通知-group)
    *   [用户相关通知 (User)](#23-用户相关通知-user)
    *   [消息相关通知 (Message)](#24-消息相关通知-message)
3.  [客户端主动请求 (Client Request via WebSocket)](#3-客户端主动请求-client-request-via-websocket)
    *   [消息同步 (Sync)](#31-消息同步-sync)
    *   [状态信令 (Signaling)](#32-状态信令-signaling)

---

## 1. HTTP 请求 (REST API)

所有 HTTP 请求采用 POST 方法，ContentType 为 `application/json`。
**通用 Header**:
*   `token`: 用户鉴权 Token
*   `operationID`: 链路追踪 ID

### 1.1 用户管理 (User)

#### `/user/get_users_info` (获取用户信息)
*   **请求参数**:
    *   `userIDs`: []string (用户 ID 列表)
*   **响应参数**:
    *   `users`: [UserInfo] (用户详细信息列表)
*   **触发 WS**: 无

#### `/user/update_user_info` (更新用户信息)
*   **请求参数**:
    *   `userInfo`: UserInfo (包含 nickname, faceURL, ex 等)
*   **响应参数**: 无
*   **触发 WS**: `OnSelfInfoUpdated` (自身), `FriendInfoUpdated` (好友收到)

---

### 1.2 好友关系 (Friend)

#### `/friend/get_friend_list` (获取好友列表)
*   **请求参数**:
    *   `pagination`: { pageNumber, showNumber }
    *   `userID`: string (当前用户ID)
*   **响应参数**:
    *   `friendsInfo`: [FriendInfo] (好友信息列表)
    *   `total`: int32
*   **触发 WS**: 无

#### `/friend/add_friend` (申请添加好友)
*   **请求参数**:
    *   `fromUserID`: string
    *   `toUserID`: string
    *   `reqMsg`: string (申请附言)
*   **响应参数**: 无
*   **触发 WS**: `FriendApplicationNotification` (接收者收到)

#### `/friend/delete_friend` (删除好友)
*   **请求参数**:
    *   `ownerUserID`: string
    *   `friendUserID`: string
*   **响应参数**: 无
*   **触发 WS**: `FriendDeletedNotification` (双方收到)

#### `/friend/add_friend_response` (处理好友申请)
*   **请求参数**:
    *   `fromUserID`: string (申请者)
    *   `toUserID`: string (处理者)
    *   `handleResult`: int32 (1-同意, -1-拒绝)
    *   `handleMsg`: string
*   **响应参数**: 无
*   **触发 WS**:
    *   同意: `FriendApplicationApprovedNotification` (申请者收到), `FriendAddedNotification` (双向)
    *   拒绝: `FriendApplicationRejectedNotification` (申请者收到)

#### `/friend/set_friend_remark` (设置备注)
*   **请求参数**:
    *   `ownerUserID`: string
    *   `friendUserID`: string
    *   `remark`: string
*   **响应参数**: 无
*   **触发 WS**: `FriendRemarkSetNotification`

---

### 1.3 群组管理 (Group)

#### `/group/create_group` (创建群组)
*   **请求参数**:
    *   `groupInfo`: GroupInfo
    *   `memberUserIDs`: []string (初始成员)
    *   `adminUserIDs`: []string (初始管理员)
    *   `ownerUserID`: string
*   **响应参数**:
    *   `groupInfo`: GroupInfo
*   **触发 WS**: `GroupCreatedNotification`

#### `/group/join_group` (申请入群)
*   **请求参数**:
    *   `groupID`: string
    *   `reqMessage`: string
    *   `joinSource`: int32
*   **响应参数**: 无
*   **触发 WS**: `JoinGroupApplicationNotification` (管理员收到)

#### `/group/quit_group` (退出群组)
*   **请求参数**:
    *   `groupID`: string
    *   `userID`: string
*   **响应参数**: 无
*   **触发 WS**: `MemberQuitNotification`

#### `/group/kick_group` (踢出群成员)
*   **请求参数**:
    *   `groupID`: string
    *   `kickedUserIDs`: []string
    *   `reason`: string
*   **响应参数**: 无
*   **触发 WS**: `MemberKickedNotification`

#### `/group/group_application_response` (处理入群申请)
*   **请求参数**:
    *   `groupID`: string
    *   `fromUserID`: string (申请者)
    *   `handleResult`: int32 (1-同意, -1-拒绝)
*   **响应参数**: 无
*   **触发 WS**:
    *   同意: `GroupApplicationAcceptedNotification`, `MemberEnterNotification`
    *   拒绝: `GroupApplicationRejectedNotification`

---

### 1.4 消息管理 (Message)

#### `/msg/send_msg` (发送消息)
*   **请求参数**:
    *   `msgData`: MsgData (发送内容)
*   **响应参数**:
    *   `serverMsgID`: string
    *   `sendTime`: int64
*   **触发 WS**: `CmdPushMsg` (核心消息推送，所有会话成员收到)

#### `/msg/revoke_msg` (撤回消息)
*   **请求参数**:
    *   `conversationID`: string
    *   `seq`: int64
    *   `userID`: string
*   **响应参数**: 无
*   **触发 WS**: `RevokeNotification`

#### `/msg/mark_msgs_as_read` (标记已读)
*   **请求参数**:
    *   `conversationID`: string
    *   `seqs`: []int64
    *   `userID`: string
*   **响应参数**: 无
*   **触发 WS**: `HasReadReceipt` (发送者收到已读回执)

---

## 2. WebSocket 事件通知 (Push Events)

当服务端通过 WebSocket 推送消息时，客户端会收到 `CmdPushMsg (2001)` 指令，其中的 `Data` 字段包含具体事件内容。

### 2.1 好友相关通知 (Friend)

| 事件 ID | 事件名称 | 触发内容 (Tips) | 触发场景 |
| :--- | :--- | :--- | :--- |
| 1201 | `FriendApplicationApproved` | FriendApplicationApprovedTips (包含申请、结果) | 你的好友申请被通过时 |
| 1202 | `FriendApplicationRejected` | FriendApplicationRejectedTips | 你的好友申请被拒绝时 |
| 1203 | `FriendApplication` | FriendApplicationTips (包含申请者信息) | 有人申请加你好友时 |
| 1204 | `FriendAdded` | FriendAddedTips (包含新好友信息) | 互为好友关系建立完成时 |
| 1205 | `FriendDeleted` | FriendDeletedTips (谁删除了谁) | 你被好友删除时 |
| 1206 | `FriendRemarkSet` | FriendInfoChangedTips | 备注修改成功时 |
| 1207 | `BlackAdded` | BlackAddedTips | 你拉黑了别人(多端同步) |
| 1208 | `BlackDeleted` | BlackDeletedTips | 你移除了黑名单(多端同步) |

### 2.2 群组相关通知 (Group)

| 事件 ID | 事件名称 | 触发内容 (Tips) | 触发场景 |
| :--- | :--- | :--- | :--- |
| 1501 | `GroupCreated` | GroupCreatedTips (群信息、成员列表) | 被拉入新建群组时 |
| 1502 | `GroupInfoSet` | GroupInfoSetTips (修改内容) | 群名、公告或头像更新时 |
| 1503 | `JoinGroupApplication` | JoinGroupApplicationTips | 有人申请进群（管理员收到） |
| 1504 | `MemberQuit` | MemberQuitTips (退群者信息) | 有成员主动退群时 |
| 1505 | `GroupApplicationAccepted`| GroupApplicationAcceptedTips | 你的入群申请被通过时 |
| 1506 | `GroupApplicationRejected`| GroupApplicationRejectedTips | 你的入群申请被拒绝时 |
| 1507 | `GroupOwnerTransferred` | GroupOwnerTransferredTips | 群主转让时 |
| 1508 | `MemberKicked` | MemberKickedTips (被踢列表) | 有成员被踢出时 |
| 1509 | `MemberInvited` | MemberInvitedTips (被邀列表) | 有新成员被邀请入群时 |
| 1510 | `MemberEnter` | MemberEnterTips | 有新成员主动入群时 |
| 1511 | `GroupDismissed` | GroupDismissedTips | 群组被解散时 |
| 1512 | `GroupMemberMuted` | GroupMemberMutedTips (禁言时长) | 成员被禁言时 |
| 1513 | `GroupMemberCancelMuted` | GroupMemberCancelMutedTips | 成员解除禁言时 |
| 1514 | `GroupMuted` | GroupMutedTips | 群开启全员禁言时 |
| 1515 | `GroupCancelMuted` | GroupCancelMutedTips | 群关闭全员禁言时 |

### 2.3 用户相关通知 (User)

| 事件 ID | 事件名称 | 触发内容 (Tips) | 触发场景 |
| :--- | :--- | :--- | :--- |
| 1303 | `UserInfoUpdated` | UserInfoUpdatedTips | 用户自己修改资料（多端同步）或好友资料变更 |
| 1304 | `UserStatusChange` | UserStatusChangeTips | 用户上线/下线状态变更 |

### 2.4 消息相关通知 (Message)

| 事件 ID | 事件名称 | 触发内容 (Tips) | 触发场景 |
| :--- | :--- | :--- | :--- |
| 2001 | `CmdPushMsg` | Wait for Decode (普通消息体) | 收到新聊天消息 |
| 2101 | `RevokeNotification` | RevokeMsgTips (撤回者、ClientMsgID) | 对方撤回消息时 |
| 2200 | `HasReadReceipt` | MarkAsReadTips (已读Seqs) | 对方标记消息已读时 |

---

## 3. 客户端主动请求 (Client Request via WebSocket)

虽然绝大多数业务操作使用 HTTP，但在以下**特殊场景**（例外情况），客户端会直接通过 WebSocket 向服务端发送请求：

### 3.1 消息同步 (Sync)
客户端重连或收到新消息通知时，为了减少 HTTP 开销并保证实时性，会通过 WS 主动拉取数据。

*   **GET_NEWEST_SEQ (1001)**: 获取服务端最新的消息 Sequence ID。
*   **PULL_MSG_BY_SEQ (1002)**: 根据 Sequence 范围拉取消息历史。

### 3.2 状态信令 (Signaling)
为了实时体验和减少对业务服务器的压力，部分“瞬态”或“长连接强相关”的状态会走 WS。

*   **SEND_MSG (1003)** - **仅限 "Typing" 状态**:  
    当用户“正在输入”时，SDK 会发送一条特殊的即时消息，内容类型为 `Typing`。这类消息不存库，仅用于实时推送到对方客户端显示“对方正在输入...”。
*   **SET_BACKGROUND_STATUS**:
    App 切换到后台/前台时，通知服务端更新在线状态（例如是否需要离线推送）。
*   **LOGOUT_MSG**:
    用户在客户端点击登出时，发送此信令断开长连接并清理服务端 Session。

**总结**: 
*   **业务状态变更**（如加好友、发普通消息）：必走 **HTTP**。
*   **数据层同步**（拉取消息）和 **瞬态信令**（输入状态、心跳）：走 **WebSocket**。
