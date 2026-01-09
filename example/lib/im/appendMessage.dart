import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin/models/im_message.dart';
import 'package:im_sdk_plugin/models/im_msg_create_info_result.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

import '../utils/sdkResponse.dart';

class AppendMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppendMessageState();
}

class AppendMessageState extends State<AppendMessage> {
  Map<String, dynamic>? resData;

  appendMessage() async {
    ImValueCallback<ImMsgCreateInfoResult> message1 =
        await ImSDKPlugin.imManager.getMessageManager().createTextMessage(text: "hhh");
    ImValueCallback<ImMsgCreateInfoResult> message2 =
        await ImSDKPlugin.imManager.getMessageManager().createTextMessage(text: "heihei");
    ImValueCallback<ImMessage> message = await ImSDKPlugin.imManager.getMessageManager()
        .appendMessage(
          createMessageBaseId: message1.data?.id ?? "",
          createMessageAppendId: message2.data?.id ?? "",
        );
    ImValueCallback<ImMessage> res = await ImSDKPlugin.imManager.getMessageManager().sendMessage(
      id: message1.data?.id ?? "",
      receiver: "940928",
      groupID: "",
    );
    setState(() {
      resData = res.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(onPressed: appendMessage, child: Text(imt("多element消息发送"))),
            ),
          ],
        ),
        SDKResponse(resData),
      ],
    );
  }
}
