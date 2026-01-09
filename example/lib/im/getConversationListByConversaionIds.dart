import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/conversationSelector.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/models/im_conversation.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetConversationByIDs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetConversationByIDsState();
}

class GetConversationByIDsState extends State<GetConversationByIDs> {
  Map<String, dynamic>? resData;
  List<String> conversaions = List.empty(growable: true);
  getConversation() async {
    ImValueCallback<List<ImConversation>> res = await ImSDKPlugin.imManager
        .getConversationManager()
        .getConversationListByConversationIds(conversationIDList: conversaions);
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
                switchSelectType: false,
                value: conversaions,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    conversaions.length > 0
                        ? conversaions.toString()
                        : imt("未选择"),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: getConversation,
                  child: Text(imt("获取会话详情")),
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
