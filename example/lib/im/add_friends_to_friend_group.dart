import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

import '../utils/sdk_response.dart';
import 'friend_group_selector.dart';
import 'friend_selector.dart';

class AddFriendsToFriendGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddFriendsToFriendGroupState();
}

class AddFriendsToFriendGroupState extends State<AddFriendsToFriendGroup> {
  Map<String, dynamic>? resData;
  List<String> fgs = List.empty(growable: true);
  List<String> users = List.empty(growable: true);

  addFriendsToFriendGroup() async {
    ImValueCallback<List<ImFriendOperationResult>> res =
        await ImSDKPlugin.imManager.getFriendshipManager().addFriendsToFriendGroup(
          groupName: fgs.first,
          userIDList: users,
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
              FriendSelector(
                onSelect: (data) {
                  setState(() {
                    users = data;
                  });
                },
                switchSelectType: false,
                value: users,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(users.length > 0 ? users.toString() : imt("未选择")),
                ),
              ),
            ],
          ),
          Row(
            children: [
              FriendGroupSelector(
                onSelect: (data) {
                  setState(() {
                    fgs = data;
                  });
                },
                switchSelectType: true,
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
                child: ElevatedButton(
                  onPressed: addFriendsToFriendGroup,
                  child: Text(imt("添加好友到分组")),
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
