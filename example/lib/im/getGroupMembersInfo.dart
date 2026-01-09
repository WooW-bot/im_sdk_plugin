import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/groupMemberSelector.dart';
import 'package:im_sdk_plugin_example/im/groupSelector.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/models/im_group_member_full_info.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetGroupMembersInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetGroupMembersInfoState();
}

class GetGroupMembersInfoState extends State<GetGroupMembersInfo> {
  Map<String, dynamic>? resData;
  List<String> group = List.empty(growable: true);
  List<String> memberList = List.empty(growable: true);

  getGroupMembersInfo() async {
    ImValueCallback<List<ImGroupMemberFullInfo>> res =
        await ImSDKPlugin.imManager
            .getGroupManager()
            .getGroupMembersInfo(
              groupID: group.first,
              memberList: memberList,
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
                  onPressed: getGroupMembersInfo,
                  child: Text(imt("获取群成员信息")),
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
