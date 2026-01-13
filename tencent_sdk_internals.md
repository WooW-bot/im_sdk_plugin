# 腾讯 IM SDK 内部机制深度分析

> **免责声明**：本文档基于对 `libImSDK.so` 二进制字符串表的分析生成。仅用于教育和调试目的，旨在帮助理解 SDK 的内部运行机制。

## 1. 本地数据库结构 (SQLite)

SDK 在本地维护了一个完整的 SQLite 数据库，用于支持离线消息查看、会话列表以及用户/群组资料的缓存。

**检测到的性能优化：**
- `PRAGMA synchronous = NORMAL;`：降低磁盘同步频率以换取更高的性能（但在断电时存在数据丢失风险）。
- `PRAGMA journal_mode=WAL;`：开启 Write-Ahead Logging（预写日志）模式，支持更高的并发性（非阻塞读取）。

### 1.1 核心表结构

#### `message` (聊天记录表)
存储所有 C2C（私聊）和 Group（群聊）的发送与接收消息。
```sql
CREATE TABLE IF NOT EXISTS message(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type INTEGER,                 -- 1: C2C (私聊), 2: Group (群聊)
    sid VARCHAR(255),             -- 会话 ID (user_id 或 group_id)
    time INTEGER,                 -- 服务器时间戳
    is_self BOOLEAN,              -- 是否由当前用户发送
    is_read BOOLEAN,              -- 已读状态
    status INTEGER,               -- 发送状态 (1: 发送中, 2: 成功, 3: 失败)
    seq UNSIGNED BIG INT,         -- 全局唯一序列号 (消息去重的核心)
    rand UNSIGNED BIG INT,        -- 随机数 (辅助去重)
    flag UNSIGNED BIG INT,
    sender VARCHAR(255),          -- 发送者 UserID
    content BLOB,                 -- 消息体 (Protobuf 序列化后的二进制数据)
    client_time INTEGER,          -- 本地客户端时间
    element_types INTEGER,        -- 消息元素类型摘要 (例如：文本、图片)
    element_descriptions VARCHAR(8192), -- 用于会话列表展示的文本描述
    read_receipt UNSIGNED BIG INT,
    read_members BLOB,            -- 已读成员列表 (仅群聊)
    extension_sequence UNSIGNED BIG INT,
    extension_content BLOB,       -- 消息扩展内容 (如消息反应 Reaction、回复引用)
    UNIQUE(type, sid, seq, rand, time, is_self)
);
```

#### `session` (会话列表表)
存储当前活跃的会话列表。
```sql
CREATE TABLE IF NOT EXISTS session(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type INTEGER,
    sid VARCHAR(255),
    msg_unread INTEGER,           -- 未读数
    active_time INTEGER,          -- 最后活跃时间戳 (用于排序)
    content BLOB,                 -- 最后一条消息的内容预览
    group_latest_seq UNSIGNED BIG INT, -- 服务器端的群最新 Seq
    group_readed_seq UNSIGNED BIG INT, -- 客户端本地已读的 Seq (用于计算未读数)
    group_revoke_time UNSIGNED BIG INT,
    c2c_readed_time UNSIGNED BIG INT,
    c2c_receipt_time UNSIGNED BIG INT,
    group_name VARCHAR(255),
    flag UNSIGNED BIG INT default 0,   -- 会话标识 (如：置顶)
    mark UNSIGNED BIG INT default 0,   -- 会话标记
    custom_info VARCHAR(1024),
    group_ids VARCHAR(1024),      -- 可能用于折叠群 ID
    UNIQUE(type, sid)
);
```

#### `userinfo` (用户资料与关系表)
统一存储用户资料和好友关系数据。
```sql
CREATE TABLE IF NOT EXISTS userinfo(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id VARCHAR(255),         -- 字符串 ID (例如 "admin")
    tiny_id UNSIGNED BIG INT,     -- 内部使用的 uint64 ID
    nick_name VARCHAR(255),
    face_url VARCHAR(255),
    gender INTEGER(255),
    birthday INTEGER,
    language INTEGER,
    location VARCHAR(255),
    signature VARCHAR(255),       -- "个性签名" / 状态
    level INTEGER,
    role INTEGER,
    allow_type INTEGER,           -- 加好友验证方式
    relation_type INTEGER,        -- 好友状态 (无, 好友, 黑名单)
    remark VARCHAR(255),          -- 好友备注
    add_time UNSIGNED BIG INT,
    add_source VARCHAR(255),
    add_wording VARCHAR(255),
    standard_sequence UNSIGNED BIG INT,
    custom_sequence UNSIGNED BIG INT,
    friend_groups BLOB,           -- 好友分组列表
    custom_user_info BLOB,        -- 用户自定义字段 (序列化数据)
    custom_friend_info BLOB,      -- 好友自定义字段 (序列化数据)
    last_update_time UNSIGNED BIG INT,
    UNIQUE(user_id)
);
```

#### `groupinfo` (群组资料表)
```sql
CREATE TABLE IF NOT EXISTS groupinfo(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id VARCHAR(255),
    group_name VARCHAR(255),
    group_type VARCHAR(255),      -- Public (公开群), Private (私有群), ChatRoom (聊天室), AVChatRoom (直播群)
    face_url VARCHAR(255),
    notification VARCHAR(255),    -- 群公告
    introduction VARCHAR(255),    -- 群简介
    create_time UNSIGNED BIG INT,
    owner_userid VARCHAR(255),
    owner_tinyid UNSIGNED BIG INT,
    member_count UNSIGNED BIG INT,
    max_member_count UNSIGNED BIG INT,
    online_member_count UNSIGNED BIG INT,
    add_option INTEGER,           -- 加群验证选项
    is_shutup_all BOOLEAN,        -- 是否开启全员禁言
    member_visible BOOLEAN,
    group_searchable BOOLEAN,
    groupinfo_sequence UNSIGNED BIG INT,    -- 资料版本号
    next_message_sequence UNSIGNED BIG INT, -- 消息连续性检查位
    last_message_timestamp UNSIGNED BIG INT,
    custom_info BLOB,
    self_role INTEGER,            -- 我在该群的角色
    self_mute_time UNSIGNED BIG INT,        -- 我的禁言过期时间
    ignored_unread_sequence BLOB,           -- "免打扰"模式的断点记录
    group_custom_string VARCHAR(8192),
    flag UNSIGNED BIG INT,
    UNIQUE(group_id)
);
```

#### `groupmemberinfo` (群成员表)
```sql
CREATE TABLE IF NOT EXISTS groupmemberinfo(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id VARCHAR(255),
    user_id VARCHAR(255),
    tiny_id UNSIGNED BIG INT,
    remark VARCHAR(255),
    name_card VARCHAR(255),       -- 群名片
    nick_name VARCHAR(255),
    face_url VARCHAR(255),
    join_time UNSIGNED BIG INT,
    shutup_time UNSIGNED BIG INT, -- 成员禁言过期时间
    role INTEGER,                 -- 成员角色 (Member, Admin, Owner)
    message_recv_option INTEGER,
    message_read_sequence UNSIGNED BIG INT,
    custom_info BLOB,
    last_update_time UNSIGNED BIG INT,
    UNIQUE(group_id, user_id)
);
```

## 2. 网络协议与引导流程 (Bootstrapping)

### 2.1 引导与 DNS
SDK 采用多层机制来确保连接的可靠性：
1.  **配置服务 (GSLB)**: `http://162.14.6.247/v4/ConfigGetSvc/GetOpenSSOIPList`
    -   这是 SDK 启动时的第一步，用于获取最优的接入层 IP 列表。
2.  **HTTPDNS (DNSPod)**: `http://119.29.29.98/d?id=39662`
    -   备用机制。如果本地 DNS 被劫持，SDK 会绕过它，直接通过 HTTP 接口查询域名对应的 IP。
3.  **连接策略**:
    -   `is_first_ip_prior`: 优先尝试列表中的第一个 IP。
    -   `is_anycast_enabled`: 支持 Anycast（任播）加速技术。
    -   `is_quic_channel_enabled`: 支持 QUIC (UDP) 协议，用于提升弱网环境下的性能。

### 2.2 内部服务 (RPC)
SDK 通过基于 Protobuf 的 RPC 指令与后端通信。

**配置与推送:**
-   `ConfigGetSvc.GetOpenSSOIPList`: 获取接入点。
-   `ConfigPushSvc.PushReq`: **服务端主动推送**。服务器可以主动将配置更新推送到客户端。
-   `ConfigPushSvc.SvrControlConf`: 服务端下发的控制配置。

**消息与同步:**
-   `C2C::RspBody::uint32_server_time`: 时间同步。
-   `RspBody::uint64_last_msg_seq`: 序列号同步（用于增量拉取）。
-   `ReportConfig::bool_sdk_log_auto_upload`: 日志自动上报的开关配置。

**群组管理:**
-   `Group::RspBody::rpt_uint64_invalid_group_member`: 错误报告，用于指示无效的成员 ID。

**商业化/VIP 能力:**
-   `RspCommercialAbility::uint64_ability`: 位掩码 (Bitmask)，指示启用的商业化功能（例如：扩展的漫游时长）。

## 3. COS (对象存储) 集成

文件传输（图片、视频、语音）直接与腾讯云 COS 交互，不经过 IM 核心服务器。

-   **工作流程**:
    1.  请求签名 -> `im_cos_msg.get_pre_sigv2`
    2.  上传至 COS -> `step3|upload local file`
    3.  发送消息 -> 消息体中包含 COS 的 URL/路径。
-   **接口**:
    -   `im_cos_msg.simple_sigv2`
    -   `im_cos_msg.get_imageinfov2`
-   **Headers**:
    -   `x-cos-request-id`: 调试 COS 错误（如上传失败、权限问题）时的关键凭证。

## 4. 内部配置键 (Internal Configuration Keys)

这些键对应于控制 SDK 行为的 C++ 类成员变量。

**登录配置 (LoginConfig):**
-   `LoginConfig::bool_first_ip_prior`
-   `LoginConfig::uint32_httpdns_timeout`: HTTPDNS 超时时间。
-   `LoginConfig::uint32_anycast_timeout`: Anycast 超时时间。

**缓存与过期 (TTL):**
-   `GroupConfig::uint32_group_info_expired_seconds`: 群资料缓存过期时间。
-   `GroupConfig::uint32_avchatroom_info_expired_seconds`: **直播群 (AVChatRoom) 专用优化**。
-   `RelationshipConfig::uint32_friend_info_expired_seconds`: 好友资料缓存过期时间。
-   `RelationshipConfig::uint32_user_info_expired_seconds`: 非好友用户资料缓存过期时间。

**上报与监控 (Reporting):**
-   `ReportConfig::uint32_net_quality_report_interval`: 网络质量统计上报的间隔时间。
