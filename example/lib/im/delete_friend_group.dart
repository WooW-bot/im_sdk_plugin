import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

import '../utils/sdk_response.dart';
import 'friend_group_selector.dart';

class DeleteFriendGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DeleteFriendGroupState();
}

class DeleteFriendGroupState extends State<DeleteFriendGroup> {
  Map<String, dynamic>? resData;
  List<String> fgs = List.empty(growable: true);

  deleteFriendGroup() async {
    ImCallback res = await ImSDKPlugin.imManager.getFriendshipManager().deleteFriendGroup(
      groupNameList: fgs,
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
          Row(
            children: [
              FriendGroupSelector(
                onSelect: (data) {
                  setState(() {
                    fgs = data;
                  });
                },
                switchSelectType: false,
                value: fgs,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(fgs.length > 0 ? fgs.toString() : imt("未选择")),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: deleteFriendGroup, child: Text(imt("删除好友分组"))),
              ),
            ],
          ),
          SDKResponse(resData),
        ],
      ),
    );
  }
}
