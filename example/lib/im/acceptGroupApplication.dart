import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/enum/group_application_type_enum.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin/models/im_callback.dart';
import 'package:im_sdk_plugin/models/im_group_application.dart';
import 'package:im_sdk_plugin/models/im_group_application_result.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

import '../utils/sdkResponse.dart';

class AcceptGroupApplication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AcceptGroupApplicationState();
}

class AcceptGroupApplicationState extends State<AcceptGroupApplication> {
  Map<String, dynamic>? resData;

  acceptGroupApplication() async {
    // ImValueCallback<ImMsgCreateInfoResult> message1 = await ImSDKPlugin.imManager.getMessageManager().createTextMessage(text: "hhh");
    // ImValueCallback<ImMsgCreateInfoResult> message2 = await ImSDKPlugin.imManager.getMessageManager().createTextMessage(text: "heihei");
    // ImValueCallback<ImMessage> message =  await ImSDKPlugin.imManager.getMessageManager().appendMessage(createMessageBaseId: message1.data?.id ?? "", createMessageAppendId: message2.data?.id ?? "");
    // ImValueCallback<ImMessage> res = await ImSDKPlugin.imManager.getMessageManager().sendMessage(id: message1.data?.id ?? "", receiver: "940928", groupID: "");
    ImValueCallback<ImGroupApplicationResult> apps = await ImSDKPlugin.imManager.getGroupManager()
        .getGroupApplicationList();
    print(apps.toJson());
    List<ImGroupApplication?>? result = apps.data?.groupApplicationList;
    ImGroupApplication? app = result?.firstWhere(
      (element) => element?.type == 1 && element?.handleStatus == 0,
    );
    print(app?.toJson());
    ImCallback res = await ImSDKPlugin.imManager.getGroupManager().acceptGroupApplication(
      fromUser: app?.fromUser ?? "",
      toUser: app?.toUser ?? "",
      groupID: app?.groupID ?? "",
      addTime: app?.addTime,
      type: GroupApplicationTypeEnum.values[app?.type ?? 0],
      reason: "",
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
              child: ElevatedButton(onPressed: acceptGroupApplication, child: Text(imt("同意进群申请"))),
            ),
          ],
        ),
        SDKResponse(resData),
      ],
    );
  }
}
