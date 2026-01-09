import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/models/im_conversation_result.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetConversationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetConversationListState();
}

class GetConversationListState extends State<GetConversationList> {
  Map<String, dynamic>? resData;
  String nextSeq = "0";

  getConversationList() async {
    ImValueCallback<ImConversationResult> res = await ImSDKPlugin
        .imManager
        .getConversationManager()
        .getConversationList(nextSeq: nextSeq, count: 10);

    setState(() {
      resData = res.toJson();
      nextSeq = res.data!.nextSeq!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text("nextSeq"),
              Container(
                child: Text(nextSeq.toString()),
                height: 60,
                margin: EdgeInsets.only(left: 12),
                alignment: Alignment.centerLeft,
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: getConversationList,
                  child: Text(imt("获取会话列表")),
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
