import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/listener/im_advanced_msg_listener.dart';
import 'package:im_sdk_plugin/listener/im_conversation_listener.dart';
import 'package:im_sdk_plugin/listener/im_friendship_listener.dart';
import 'package:im_sdk_plugin/listener/im_group_listener.dart';
import 'package:im_sdk_plugin/listener/im_signaling_listener.dart';
import 'package:im_sdk_plugin/listener/im_simple_msg_listener.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin/models/im_message_download_progress.dart';
import 'package:im_sdk_plugin/models/im_message_extension.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';
import 'package:provider/provider.dart';

import '../provider/event.dart';

class AddEventListener extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddEventListenerState();
}

class AddEventListenerState extends State<AddEventListener> {
  //late ImSimpleMsgListener simpleMsgListener;
  late ImAdvancedMsgListener advancedMsgListener;
  late ImSignalingListener signalingListener;
  late ImConversationListener conversationListener;
  late ImFriendshipListener friendshipListener;
  late ImGroupListener groupListener;

  addEventListener() async {
    /*    simpleMsgListener = new ImSimpleMsgListener(
      onRecvC2CCustomMessage: Provider.of<Event>(context, listen: false).onRecvC2CCustomMessage,
      onRecvC2CTextMessage: Provider.of<Event>(context, listen: false).onRecvC2CTextMessage,
      onRecvGroupCustomMessage: Provider.of<Event>(context, listen: false).onRecvGroupCustomMessage,
      onRecvGroupTextMessage: Provider.of<Event>(context, listen: false).onRecvGroupTextMessage,
    );*/

    groupListener = ImGroupListener(
      onApplicationProcessed: Provider.of<Event>(
        context,
        listen: false,
      ).onApplicationProcessed,
      onGrantAdministrator: Provider.of<Event>(
        context,
        listen: false,
      ).onGrantAdministrator,
      onGroupAttributeChanged: Provider.of<Event>(
        context,
        listen: false,
      ).onGroupAttributeChanged,
      onGroupCreated: Provider.of<Event>(context, listen: false).onGroupCreated,
      onGroupDismissed: Provider.of<Event>(
        context,
        listen: false,
      ).onGroupDismissed,
      onGroupInfoChanged: Provider.of<Event>(
        context,
        listen: false,
      ).onGroupInfoChanged,
      onGroupRecycled: Provider.of<Event>(
        context,
        listen: false,
      ).onGroupRecycled,
      onMemberEnter: Provider.of<Event>(context, listen: false).onMemberEnter,
      onMemberInfoChanged: Provider.of<Event>(
        context,
        listen: false,
      ).onMemberInfoChanged,
      onMemberInvited: Provider.of<Event>(
        context,
        listen: false,
      ).onMemberInvited,
      onMemberKicked: Provider.of<Event>(context, listen: false).onMemberKicked,
      onMemberLeave: Provider.of<Event>(context, listen: false).onMemberLeave,
      onQuitFromGroup: Provider.of<Event>(
        context,
        listen: false,
      ).onQuitFromGroup,
      onReceiveJoinApplication: Provider.of<Event>(
        context,
        listen: false,
      ).onReceiveJoinApplication,
      onReceiveRESTCustomData: Provider.of<Event>(
        context,
        listen: false,
      ).onReceiveRESTCustomData,
      onRevokeAdministrator: Provider.of<Event>(
        context,
        listen: false,
      ).onRevokeAdministrator,
      onTopicCreated: Provider.of<Event>(context, listen: false).onTopicCreated,
      onTopicDeleted: Provider.of<Event>(context, listen: false).onTopicDeleted,
      onTopicInfoChanged: Provider.of<Event>(
        context,
        listen: false,
      ).onTopicInfoChanged,
    );
    advancedMsgListener = new ImAdvancedMsgListener(
      onRecvC2CReadReceipt: Provider.of<Event>(
        context,
        listen: false,
      ).onRecvC2CReadReceipt,
      onRecvMessageRevoked: Provider.of<Event>(
        context,
        listen: false,
      ).onRecvMessageRevoked,
      onRecvNewMessage: Provider.of<Event>(
        context,
        listen: false,
      ).onRecvNewMessage,
      onSendMessageProgress: Provider.of<Event>(
        context,
        listen: false,
      ).onSendMessageProgress,
      onRecvMessageReadReceipts: Provider.of<Event>(
        context,
        listen: false,
      ).onRecvMessageReadReceipts,
      onRecvMessageModified: Provider.of<Event>(
        context,
        listen: false,
      ).onRecvMessageModified,
      onRecvMessageExtensionsChanged:
          (String msgID, List<ImMessageExtension> extList) {
            print("onRecvMessageExtensionsChanged $msgID");
            extList.forEach((element) {
              print(element.toJson());
            });
          },
      onRecvMessageExtensionsDeleted: (String msgID, List<String> keys) {
        print("onRecvMessageExtensionsDeleted $msgID");
        print(keys);
      },
      onMessageDownloadProgressCallback:
          (ImMessageDownloadProgress messageProgress) {
            print("下载进度");
            print(messageProgress.toJson());
          },
    );

    signalingListener = new ImSignalingListener(
      onInvitationCancelled: Provider.of<Event>(
        context,
        listen: false,
      ).onInvitationCancelled,
      onInvitationTimeout: Provider.of<Event>(
        context,
        listen: false,
      ).onInvitationTimeout,
      onInviteeAccepted: Provider.of<Event>(
        context,
        listen: false,
      ).onInviteeAccepted,
      onInviteeRejected: Provider.of<Event>(
        context,
        listen: false,
      ).onInviteeRejected,
      onReceiveNewInvitation: Provider.of<Event>(
        context,
        listen: false,
      ).onReceiveNewInvitation,
    );

    conversationListener = new ImConversationListener(
      onConversationChanged: Provider.of<Event>(
        context,
        listen: false,
      ).onConversationChanged,
      onNewConversation: Provider.of<Event>(
        context,
        listen: false,
      ).onNewConversation,
      onSyncServerFailed: Provider.of<Event>(
        context,
        listen: false,
      ).onSyncServerFailed,
      onSyncServerFinish: Provider.of<Event>(
        context,
        listen: false,
      ).onSyncServerFinish,
      onSyncServerStart: Provider.of<Event>(
        context,
        listen: false,
      ).onSyncServerStart,
      onConversationGroupCreated: Provider.of<Event>(
        context,
        listen: false,
      ).onConversationGroupCreated,
      onConversationGroupDeleted: Provider.of<Event>(
        context,
        listen: false,
      ).onConversationGroupDeleted,
      onConversationGroupNameChanged: Provider.of<Event>(
        context,
        listen: false,
      ).onConversationGroupNameChanged,
      onConversationsAddedToGroup: Provider.of<Event>(
        context,
        listen: false,
      ).onConversationsAddedToGroup,
      onConversationsDeletedFromGroup: Provider.of<Event>(
        context,
        listen: false,
      ).onConversationsDeletedFromGroup,
    );

    friendshipListener = new ImFriendshipListener(
      onFriendApplicationListAdded: Provider.of<Event>(
        context,
        listen: false,
      ).onFriendApplicationListAdded,
      onFriendInfoChanged: Provider.of<Event>(
        context,
        listen: false,
      ).onFriendInfoChanged,
    );
    //注册简单消息监听器
    // ignore: deprecated_member_use
    // await ImSDKPlugin.imManager.addSimpleMsgListener(listener: simpleMsgListener);
    //注册群组消息监听器
    await ImSDKPlugin.imManager.getGroupManager().setGroupListener(
      groupListener,
    );
    //注册高级消息监听器
    await ImSDKPlugin.imManager.getMessageManager().setAdvancedMsgListener(
      advancedMsgListener,
    );

    //注册会话监听器
    await ImSDKPlugin.imManager
        .getConversationManager()
        .setConversationListener(conversationListener);
    //注册关系链监听器
    await ImSDKPlugin.imManager.getFriendshipManager().setFriendListener(
      friendshipListener,
    );
    //注册信令消息监听器
    await ImSDKPlugin.imManager.getSignalingManager().setSignalingListener(
      signalingListener,
    );
  }

  /*  removeSimpleMsgListener() async {
    await ImSDKPlugin.imManager.removeSimpleMsgListener(listener: simpleMsgListener);
  }*/

  /*  removeAllSimpleMsgListener() async {
    await ImSDKPlugin.imManager.removeSimpleMsgListener();
  }*/

  removeAdvanceMsgListener() async {
    await ImSDKPlugin.imManager.getMessageManager().setAdvancedMsgListener(
      null,
    );
  }

  removeAllAdvanceMsgListener() async {
    await ImSDKPlugin.imManager.getMessageManager().setAdvancedMsgListener(
      null,
    );
  }

  removeSignalingListener() async {
    await ImSDKPlugin.imManager.getSignalingManager().setSignalingListener(
      null,
    );
  }

  removeAllSignalingListener() async {
    await ImSDKPlugin.imManager.getSignalingManager().setSignalingListener(
      null,
    );
  }

  removeGroupListener() async {
    await ImSDKPlugin.imManager.getGroupManager().setGroupListener(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          new ElevatedButton(
            onPressed: addEventListener,
            child: Text(imt("注册事件")),
          ),
          /*          new ElevatedButton(
            onPressed: removeSimpleMsgListener,
            child: Text(imt("注销simpleMsgListener事件")),
          ),*/
          /*          new ElevatedButton(
            onPressed: removeAllSimpleMsgListener,
            child: Text(imt("注销所有simpleMsgListener事件")),
          ),*/
          new ElevatedButton(
            onPressed: removeAdvanceMsgListener,
            child: Text(imt("注销advanceMsgListener")),
          ),
          new ElevatedButton(
            onPressed: removeAllAdvanceMsgListener,
            child: Text(imt("注销所有advanceMsgListener")),
          ),
          new ElevatedButton(
            onPressed: removeSignalingListener,
            child: Text(imt("注销signalingListener")),
          ),
          new ElevatedButton(
            onPressed: removeAllSignalingListener,
            child: Text(imt("注销所有signalingListener")),
          ),
          new ElevatedButton(
            onPressed: removeGroupListener,
            child: Text(imt("注销gruopListener")),
          ),
        ],
      ),
    );
  }
}
