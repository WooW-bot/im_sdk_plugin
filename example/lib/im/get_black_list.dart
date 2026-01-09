import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/models/im_friend_info.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetBlackList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetBlackListState();
}

class GetBlackListState extends State<GetBlackList> {
  Map<String, dynamic>? resData;
  getBlackList() async {
    ImValueCallback<List<ImFriendInfo>> res = await ImSDKPlugin
        .imManager
        .getFriendshipManager()
        .getBlackList();
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
                  onPressed: getBlackList,
                  child: Text(imt("获取黑名单列表")),
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
