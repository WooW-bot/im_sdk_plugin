import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin/models/im_signaling_info.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

import '../utils/sdk_response.dart';
import 'conversation_selector.dart';
import 'message_selector.dart';

class AddInvitedSignaling extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddInvitedSignalingState();
}

class AddInvitedSignalingState extends State<AddInvitedSignaling> {
  Map<String, dynamic>? resData;
  List<String> receiver = List.empty(growable: true);
  List<String> groupID = List.empty(growable: true);
  int priority = 0;
  bool onlineUserOnly = false;
  bool isExcludedFromUnreadCount = false;
  List<String> conversaions = List.empty(growable: true);
  List<String> msgIDs = List.empty(growable: true);

  getSignalingInfo() async {
    var signalInfo = await ImSDKPlugin.imManager.getSignalingManager().getSignalingInfo(
      msgID: msgIDs[0],
    );

    ImSignalingInfo info = ImSignalingInfo(
      actionType: signalInfo.data!.actionType,
      timeout: signalInfo.data!.timeout,
      inviteID: signalInfo.data!.inviteID,
      data: signalInfo.data!.data,
      groupID: signalInfo.data!.groupID,
      businessID: 1,
      isOnlineUserOnly: false,
      offlinePushInfo: OfflinePushInfo(),
      inviter: signalInfo.data!.inviter,
      inviteeList: signalInfo.data!.inviteeList,
    );
    var res = await ImSDKPlugin.imManager.getSignalingManager().addInvitedSignaling(info: info);

    setState(() {
      resData = res.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          new Row(
            children: [
              ConversationSelector(
                onSelect: (data) {
                  setState(() {
                    conversaions = data;
                  });
                },
                switchSelectType: true,
                value: conversaions,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(conversaions.length > 0 ? conversaions.toString() : imt("未选择")),
                ),
              ),
            ],
          ),
          Row(
            children: [
              MessageSelector(conversaions.isNotEmpty ? conversaions.first : "", msgIDs, (data) {
                setState(() {
                  msgIDs = data;
                });
              }),
              Expanded(
                child: Container(margin: EdgeInsets.only(left: 12), child: Text(msgIDs.toString())),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: getSignalingInfo,
                  child: Text(imt("添加信令信息（选择已有的信令信息进行测试）")),
                ),
              ),
            ],
          ),
          SDKResponse(resData),
        ],
      ),
    );
  }
}
