import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetFriendApplicationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetFriendApplicationListState();
}

class GetFriendApplicationListState extends State<GetFriendApplicationList> {
  Map<String, dynamic>? resData;
  getFriendApplicationList() async {
    ImValueCallback<ImFriendApplicationResult> res =
        await ImSDKPlugin.imManager
            .getFriendshipManager()
            .getFriendApplicationList();
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
                  onPressed: getFriendApplicationList,
                  child: Text(imt("获取好友申请列表")),
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
