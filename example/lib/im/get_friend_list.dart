import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/models/im_friend_info.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetFriendList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetFriendListState();
}

class GetFriendListState extends State<GetFriendList> {
  Map<String, dynamic>? resData;
  getFriendList() async {
    ImValueCallback<List<ImFriendInfo>> res = await ImSDKPlugin.imManager
        .getFriendshipManager()
        .getFriendList();
    setState(() {
      resData = res.toJson();
    });
  }

  syncFriendList() async {
    ImValueCallback<List<ImFriendInfo>> res = await ImSDKPlugin.imManager
        .getFriendshipManager()
        .syncFriendList();
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
                  onPressed: getFriendList,
                  child: Text(imt("获取好友列表")),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: syncFriendList,
                  child: Text(imt("同步好友列表")),
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
