import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/friend_selector.dart';
import 'package:im_sdk_plugin_example/im/group_selector.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class InviteUserToGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InviteUserToGroupState();
}

class InviteUserToGroupState extends State<InviteUserToGroup> {
  Map<String, dynamic>? resData;
  List<String> group = List.empty(growable: true);
  List<String> memberList = List.empty(growable: true);
  inviteUserToGroup() async {
    ImValueCallback<List<ImGroupMemberOperationResult>> res =
        await ImSDKPlugin.imManager
            .getGroupManager()
            .inviteUserToGroup(
              groupID: group.first,
              userList: memberList, //注意：选择器没做单选，所以这里选第一个
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
              GroupSelector(
                onSelect: (data) {
                  setState(() {
                    group = data;
                  });
                },
                switchSelectType: true,
                value: group,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(group.length > 0 ? group.toString() : imt("未选择")),
                ),
              )
            ],
          ),
          Row(
            children: [
              FriendSelector(
                onSelect: (data) {
                  setState(() {
                    memberList = data;
                  });
                },
                switchSelectType: false,
                value: memberList,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                      memberList.length > 0 ? memberList.toString() : imt("未选择")),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: inviteUserToGroup,
                  child: Text(imt("邀请好友进群")),
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
