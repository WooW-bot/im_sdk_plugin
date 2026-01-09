import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/conversationSelector.dart';
import 'package:im_sdk_plugin_example/im/messageSelector.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/models/im_message.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class ReSendMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReSendMessageState();
}

class ReSendMessageState extends State<ReSendMessage> {
  Map<String, dynamic>? resData;
  List<String> receiver = List.empty(growable: true);
  List<String> groupID = List.empty(growable: true);
  int priority = 0;
  bool onlineUserOnly = false;
  bool isExcludedFromUnreadCount = false;
  List<String> conversaions = List.empty(growable: true);
  List<String> msgIDs = List.empty(growable: true);
  reSendMessage() async {
    // 注意：web下 reSendMessage 的webMessageInstatnce 为必填写（msgID和onlineUserOnly可不填写）
    ImValueCallback<ImMessage> res =
        await ImSDKPlugin.imManager.getMessageManager().reSendMessage(
              msgID: msgIDs.first,
              onlineUserOnly: onlineUserOnly,
            );
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
                  child: Text(conversaions.length > 0
                      ? conversaions.toString()
                      : imt("未选择")),
                ),
              )
            ],
          ),
          Row(
            children: [
              MessageSelector(
                conversaions.isNotEmpty ? conversaions.first : "",
                msgIDs,
                (data) {
                  setState(() {
                    msgIDs = data;
                  });
                },
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(msgIDs.toString()),
              ))
            ],
          ),
          Row(
            children: [
              Text(imt("是否仅在线用户接受到消息")),
              Switch(
                value: onlineUserOnly,
                onChanged: (res) {
                  setState(() {
                    onlineUserOnly = res;
                  });
                },
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: reSendMessage,
                  child: Text(imt("重发消息")),
                ),
              )
            ],
          ),
          SDKResponse(resData),
        ],
      ),
    );
  }
}
