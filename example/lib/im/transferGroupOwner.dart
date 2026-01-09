import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';
import 'package:im_sdk_plugin_example/im/groupMemberSelector.dart';
import 'package:im_sdk_plugin_example/im/groupSelector.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/enum/group_member_role.dart';
import 'package:im_sdk_plugin/models/im_callback.dart';

class TransferGroupOwner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TransferGroupOwnerState();
}

class TransferGroupOwnerState extends State<TransferGroupOwner> {
  Map<String, dynamic>? resData;
  List<String> group = List.empty(growable: true);
  List<String> memberList = List.empty(growable: true);
  int role = GroupMemberRoleType.IM_GROUP_MEMBER_ROLE_MEMBER;
  transferGroupOwner() async {
    ImCallback res = await ImSDKPlugin.imManager
        .getGroupManager()
        .transferGroupOwner(
          groupID: group.first,
          userID: memberList.first, //注意：选择器没做单选，所以这里选第一个
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
              GroupMemberSelector(
                group.isNotEmpty ? group.first : "",
                memberList,
                (data) {
                  setState(() {
                    memberList = data;
                  });
                },
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(memberList.toString()),
              ))
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: transferGroupOwner,
                  child: Text(imt("转移群主")),
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
