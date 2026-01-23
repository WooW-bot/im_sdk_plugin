import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

import '../utils/sdk_response.dart';
import 'conversation_selector.dart';

class DeleteConversation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DeleteConversationState();
}

class DeleteConversationState extends State<DeleteConversation> {
  Map<String, dynamic>? resData;
  List<String> conversaions = List.empty(growable: true);

  deleteConversation() async {
    ImCallback res = await ImSDKPlugin.imManager.getConversationManager().deleteConversation(
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
                  child: Text(conversaions.length > 0 ? conversaions.toString() : imt("未选择")),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: deleteConversation, child: Text(imt("删除会话"))),
              ),
            ],
          ),
          SDKResponse(resData),
        ],
      ),
    );
  }
}
