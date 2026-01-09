import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin/models/im_friend_operation_result.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

import '../utils/sdk_response.dart';
import 'friend_selector.dart';

class CreateFriendGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateFriendGroupState();
}

class CreateFriendGroupState extends State<CreateFriendGroup> {
  Map<String, dynamic>? resData;
  String groupName = '';
  List<String> users = List.empty(growable: true);
  createFriendGroup() async {
    ImValueCallback<List<ImFriendOperationResult>> res =
        await ImSDKPlugin.imManager
            .getFriendshipManager()
            .createFriendGroup(
              userIDList: users.isNotEmpty ? users : null,
              groupName: groupName,
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
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: imt("分组名"),
                    hintText: imt("分组名"),
                    prefixIcon: Icon(Icons.person),
                  ),
                  onChanged: (res) {
                    setState(() {
                      groupName = res;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: createFriendGroup,
                  child: Text(imt("创建好友分组")),
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
