import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:im_sdk_plugin_example/im/communitySelector.dart';
import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/groupSelector.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/enum/group_member_filter_enum.dart';
import 'package:im_sdk_plugin/models/im_group_member_info_result.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetTopicList extends StatefulWidget {
  const GetTopicList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GetGroupMemberListState();
}

class GetGroupMemberListState extends State<GetTopicList> {
  Map<String, dynamic>? resData;
  List<String> group = List.empty(growable: true);
  GroupMemberFilterTypeEnum filter =
      GroupMemberFilterTypeEnum.IM_GROUP_MEMBER_FILTER_ALL;
  String nextSeq = "0";
  getTopicList() async {
    final res = await ImSDKPlugin.imManager
        .getGroupManager()
        .getTopicInfoList(groupID: group.first, topicIDList: []);
    setState(() {
      resData = res.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CommunityGroupSelector(
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
            Expanded(
              child: ElevatedButton(
                onPressed: getTopicList,
                child: Text(imt("获取话题列表")),
              ),
            )
          ],
        ),
        SDKResponse(resData),
      ],
    );
  }
}
