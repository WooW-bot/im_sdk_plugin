import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class ModifyMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ModifyMessageState();
}

class ModifyMessageState extends State<ModifyMessage> {
  Map<String, dynamic>? resData;
  modifyMessage() async {
    ImValueCallback<ImMsgCreateInfoResult> cusMessage =
        await ImSDKPlugin.imManager
            .getMessageManager()
            .createCustomMessage(data: "hehhe");
    ImValueCallback<ImMessage> msg = await ImSDKPlugin.imManager
        .getMessageManager()
        .sendMessage(id: cusMessage.data!.id!, receiver: "121405", groupID: "");
    msg.data!.customElem?.data = "haha";
    if (kIsWeb) {
      final decodedMessage = jsonDecode(msg.data!.messageFromWeb!);
      decodedMessage['payload']['data'] = 'hhaaha';
      msg.data!.messageFromWeb = jsonEncode(decodedMessage);
      print(msg.data!.messageFromWeb);
    }
    ImValueCallback<ImMessageChangeInfo> res = await ImSDKPlugin
        .imManager
        .getMessageManager()
        .modifyMessage(message: msg.data!);

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
              child: ElevatedButton(
                onPressed: modifyMessage,
                child: Text(imt("修改消息")),
              ),
            )
          ],
        ),
        SDKResponse(resData),
      ],
    );
  }
}
