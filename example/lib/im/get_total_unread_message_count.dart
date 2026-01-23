import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetTotalUnreadMessageCount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetTotalUnreadMessageCountState();
}

class GetTotalUnreadMessageCountState
    extends State<GetTotalUnreadMessageCount> {
  Map<String, dynamic>? resData;
  getTotalUnreadMessageCount() async {
    ImValueCallback<int> res = await ImSDKPlugin.imManager
        .getConversationManager()
        .getTotalUnreadMessageCount();
    setState(() {
      resData = res.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: getTotalUnreadMessageCount,
                  child: Text(imt("获取会话未读总数")),
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
