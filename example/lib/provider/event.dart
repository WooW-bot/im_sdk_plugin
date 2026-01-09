import 'package:flutter/cupertino.dart';
import 'package:im_sdk_plugin/models/im_conversation.dart';
import 'package:im_sdk_plugin/models/im_friend_application.dart';
import 'package:im_sdk_plugin/models/im_friend_info.dart';
import 'package:im_sdk_plugin/models/im_group_change_info.dart';
import 'package:im_sdk_plugin/models/im_group_member_change_info.dart';
import 'package:im_sdk_plugin/models/im_group_member_info.dart';
import 'package:im_sdk_plugin/models/im_message.dart';
import 'package:im_sdk_plugin/models/im_message_receipt.dart';
import 'package:im_sdk_plugin/models/im_topic_info.dart';
import 'package:im_sdk_plugin/models/im_user_full_info.dart';
import 'package:im_sdk_plugin/models/im_user_info.dart';
import 'package:im_sdk_plugin/models/im_user_status.dart';

class Event with ChangeNotifier {
  List<Map<String, dynamic>> events = List.empty(growable: true);

  void addEvents(Map<String, dynamic> event) {
    this.events.add(event);
    notifyListeners();
  }

  void clearEvents() {
    this.events.clear();
    notifyListeners();
  }

  // initListenr
  void onConnectFailed(int code, String error) {
    this.addEvents(
      Map<String, dynamic>.from({"type": "onConnectFailed", "code": code, "error": error}),
    );
  }

  void onConnectSuccess() {
    this.addEvents(Map<String, dynamic>.from({"type": "onConnectSuccess"}));
  }

  void onConnecting() {
    this.addEvents(Map<String, dynamic>.from({"type": "onConnecting"}));
  }

  void onKickedOffline() {
    this.addEvents(Map<String, dynamic>.from({"type": "onKickedOffline"}));
  }

  void onSelfInfoUpdated(ImUserFullInfo info) {
    this.addEvents(Map<String, dynamic>.from({"type": "onSelfInfoUpdated", "info": info.toJson()}));
  }

  void onUserSigExpired() {
    this.addEvents(Map<String, dynamic>.from({"type": "onUserSigExpired"}));
  }

  // ImSimpleMsgListener
  void onRecvC2CCustomMessage(String msgID, ImUserInfo sender, String customData) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onRecvC2CCustomMessage",
        "msgID": msgID,
        "sender": sender.toJson(),
        "customData": customData,
      }),
    );
  }

  void onRecvC2CTextMessage(String msgID, ImUserInfo userInfo, String text) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onRecvC2CTextMessage",
        "msgID": msgID,
        "userInfo": userInfo.toJson(),
        "text": text,
      }),
    );
  }

  void onRecvGroupCustomMessage(
    String msgID,
    String groupID,
    ImGroupMemberInfo sender,
    String customData,
  ) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onRecvGroupCustomMessage",
        "msgID": msgID,
        "groupID": groupID,
        "sender": sender.toJson(),
        "customData": customData,
      }),
    );
  }

  void onRecvGroupTextMessage(String msgID, String groupID, ImGroupMemberInfo sender, String text) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onRecvGroupTextMessage",
        "msgID": msgID,
        "groupID": groupID,
        "sender": sender.toJson(),
        "text": text,
      }),
    );
  }

  // ImGroupListener
  void onApplicationProcessed(
    String groupID,
    ImGroupMemberInfo opUser,
    bool isAgreeJoin,
    String opReason,
  ) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onApplicationProcessed",
        "groupID": groupID,
        "opUser": opUser.toJson(),
        "isAgreeJoin": isAgreeJoin,
        "opReason": opReason,
      }),
    );
  }

  void onGrantAdministrator(
    String groupID,
    ImGroupMemberInfo opUser,
    List<ImGroupMemberInfo> memberList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    memberList.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onGrantAdministrator",
        "groupID": groupID,
        "opUser": opUser.toJson(),
        "memberList": ml,
      }),
    );
  }

  void onGroupAttributeChanged(String groupID, Map<String, String> groupAttributeMap) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onGroupAttributeChanged",
        "groupID": groupID,
        "groupAttributeMap": groupAttributeMap,
      }),
    );
  }

  void onGroupCreated(groupID) {
    this.addEvents(Map<String, dynamic>.from({"type": "onGroupCreated", "groupID": groupID}));
  }

  void onGroupDismissed(String groupID, ImGroupMemberInfo opUser) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onGroupDismissed",
        "groupID": groupID,
        "opUser": opUser.toJson(),
      }),
    );
  }

  void onGroupInfoChanged(String groupID, List<ImGroupChangeInfo> changeInfos) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    changeInfos.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onGroupInfoChanged",
        "groupID": groupID,
        "changeInfos": ml,
      }),
    );
  }

  void onGroupRecycled(String groupID, ImGroupMemberInfo opUser) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onGroupRecycled",
        "groupID": groupID,
        "opUser": opUser.toJson(),
      }),
    );
  }

  void onMemberEnter(String groupID, List<ImGroupMemberInfo> memberList) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    memberList.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(
      Map<String, dynamic>.from({"type": "onMemberEnter", "groupID": groupID, "memberList": ml}),
    );
  }

  void onMemberInfoChanged(
    String groupID,
    List<ImGroupMemberChangeInfo> IMGroupMemberChangeInfoList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    IMGroupMemberChangeInfoList.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onMemberInfoChanged",
        "groupID": groupID,
        "IMGroupMemberChangeInfoList": ml,
      }),
    );
  }

  void onMemberInvited(
    String groupID,
    ImGroupMemberInfo opUser,
    List<ImGroupMemberInfo> memberList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    memberList.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onMemberInvited",
        "groupID": groupID,
        "opUser": opUser.toJson(),
        "memberList": ml,
      }),
    );
  }

  void onMemberKicked(
    String groupID,
    ImGroupMemberInfo opUser,
    List<ImGroupMemberInfo> memberList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    memberList.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onMemberKicked",
        "groupID": groupID,
        "opUser": opUser.toJson(),
        "memberList": ml,
      }),
    );
  }

  void onMemberLeave(String groupID, ImGroupMemberInfo member) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onMemberLeave",
        "groupID": groupID,
        "member": member.toJson(),
      }),
    );
  }

  void onQuitFromGroup(String groupID) {
    this.addEvents(Map<String, dynamic>.from({"type": "onQuitFromGroup", "groupID": groupID}));
  }

  void onReceiveJoinApplication(String groupID, ImGroupMemberInfo member, String opReason) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onReceiveJoinApplication",
        "groupID": groupID,
        "member": member.toJson(),
        "opReason": opReason,
      }),
    );
  }

  void onReceiveRESTCustomData(String groupID, String customData) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onReceiveRESTCustomData",
        "groupID": groupID,
        "customData": customData,
      }),
    );
  }

  void onRevokeAdministrator(
    String groupID,
    ImGroupMemberInfo opUser,
    List<ImGroupMemberInfo> memberList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    memberList.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onRevokeAdministrator",
        "groupID": groupID,
        "opUser": opUser.toJson(),
        "memberList": ml,
      }),
    );
  }

  // ImAdvancedMsgListener
  void onRecvC2CReadReceipt(List<ImMessageReceipt> receiptList) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    receiptList.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(Map<String, dynamic>.from({"type": "onRecvC2CReadReceipt", "receiptList": ml}));
  }

  void onRecvMessageRevoked(String msgID) {
    this.addEvents(Map<String, dynamic>.from({"type": "onRecvMessageRevoked", "msgID": msgID}));
  }

  void onRecvNewMessage(ImMessage msg) {
    print("收到消息");
    print(msg.toJson());
    this.addEvents(Map<String, dynamic>.from({"type": "onRecvNewMessage", "msg": msg.toJson()}));
  }

  void onSendMessageProgress(ImMessage message, int progress) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onSendMessageProgress",
        "message": message.toJson(),
        "progress": progress,
      }),
    );
  }

  void onRecvMessageReadReceipts(List<ImMessageReceipt> data) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    data.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(Map<String, dynamic>.from({"type": "onRecvMessageReadReceipts", "data": ml}));
  }

  void onRecvMessageModified(ImMessage msg) {
    this.addEvents(
      Map<String, dynamic>.from({"type": "onRecvMessageModified", "data": msg.toJson()}),
    );
  }

  // 信令
  void onInvitationCancelled(String inviteID, String inviter, String data) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onInvitationCancelled",
        "inviteID": inviteID,
        "inviter": inviter,
        "data": data,
      }),
    );
  }

  void onInvitationTimeout(String inviteID, List<String> inviteeList) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onInvitationTimeout",
        "inviteID": inviteID,
        "inviteeList": inviteeList,
      }),
    );
  }

  void onUserStatusChanged(List<ImUserStatus> statusList) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    statusList.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(Map<String, dynamic>.from({"type": "onUserStatusChanged", "data": ml}));
  }

  void onTopicCreated(String groupID, String topicID) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onTopicCreated",
        "data": Map.from({"groupID": groupID, "topicID": topicID}),
      }),
    );
  }

  void onTopicDeleted(String groupID, List<String> topicIDList) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onTopicCronTopicDeletedeated",
        "data": Map.from({"groupID": groupID, "topicIDList": topicIDList}),
      }),
    );
  }

  void onTopicInfoChanged(String groupID, ImTopicInfo topicInfo) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onTopicInfoChanged",
        "data": Map.from({"groupID": groupID, "topicInfo": topicInfo.toJson()}),
      }),
    );
  }

  void onConversationGroupCreated(String groupName, List<ImConversation> conversationList) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onConversationGroupCreated",
        "data": Map.from({
          "groupName": groupName,
          "conversationList": conversationList.map((e) => e.toJson()).toList(),
        }),
      }),
    );
  }

  void onConversationGroupDeleted(String groupName) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onConversationGroupDeleted",
        "data": Map.from({"groupName": groupName}),
      }),
    );
  }

  void onConversationGroupNameChanged(String oldName, String newName) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onConversationGroupNameChanged",
        "data": Map.from({"oldName": oldName, "newName": newName}),
      }),
    );
  }

  void onConversationsAddedToGroup(String groupName, List<ImConversation> conversationList) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onConversationsAddedToGroup",
        "data": Map.from({
          "groupName": groupName,
          "conversationList": conversationList.map((e) => e.toJson()).toList(),
        }),
      }),
    );
  }

  void onConversationsDeletedFromGroup(String groupName, List<ImConversation> conversationList) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onConversationsDeletedFromGroup",
        "data": Map.from({
          "groupName": groupName,
          "conversationList": conversationList.map((e) => e.toJson()).toList(),
        }),
      }),
    );
  }

  void onInviteeAccepted(String inviteID, String invitee, String data) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onInviteeAccepted",
        "inviteID": inviteID,
        "invitee": invitee,
        "data": data,
      }),
    );
  }

  void onInviteeRejected(String inviteID, String invitee, String data) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onInviteeRejected",
        "inviteID": inviteID,
        "invitee": invitee,
        "data": data,
      }),
    );
  }

  void onReceiveNewInvitation(
    String inviteID,
    String inviter,
    String groupID,
    List<String> inviteeList,
    String data,
  ) {
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onReceiveNewInvitation",
        "inviteID": inviteID,
        "groupID": groupID,
        "inviter": inviter,
        "inviteeList": inviteeList,
        "data": data,
      }),
    );
  }

  // 会话
  void onConversationChanged(List<ImConversation> conversationList) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    conversationList.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(
      Map<String, dynamic>.from({"type": "onConversationChanged", "conversationList": ml}),
    );
  }

  void onNewConversation(List<ImConversation> conversationList) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    conversationList.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(
      Map<String, dynamic>.from({"type": "onNewConversation", "conversationList": ml}),
    );
  }

  void onFriendApplicationListAdded(List<ImFriendApplication> friendApplicationList) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    friendApplicationList.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(
      Map<String, dynamic>.from({
        "type": "onFriendApplicationListAdded",
        "friendApplicationList": ml,
      }),
    );
  }

  void onFriendInfoChanged(List<ImFriendInfo> data) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    data.forEach((element) {
      ml.add(element.toJson());
    });
    this.addEvents(
      Map<String, dynamic>.from({"type": "onFriendInfoChanged", "ImFriendInfoList": ml}),
    );
  }

  void onSyncServerFailed() {
    this.addEvents(Map<String, dynamic>.from({"type": "onSyncServerFailed"}));
  }

  void onSyncServerFinish() {
    this.addEvents(Map<String, dynamic>.from({"type": "onSyncServerFinish"}));
  }

  void onSyncServerStart() {
    this.addEvents(Map<String, dynamic>.from({"type": "onSyncServerStart"}));
  }
}
