import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/conversation_selector.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/models/im_conversation.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetConversation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetConversationState();
}

class GetConversationState extends State<GetConversation> {
  Map<String, dynamic>? resData;
  List<String> conversaions = List.empty(growable: true);
  getConversation() async {
    ImValueCallback<ImConversation> res = await ImSDKPlugin
        .imManager
        .getConversationManager()
        .getConversation(
          conversationID: conversaions.first,
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
              Expanded(
                child: ElevatedButton(
                  onPressed: getConversation,
                  child: Text(imt("获取会话详情")),
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
