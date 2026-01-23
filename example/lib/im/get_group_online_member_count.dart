import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/group_selector.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetGroupOnlineMemberCount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetGroupOnlineMemberCountState();
}

class GetGroupOnlineMemberCountState extends State<GetGroupOnlineMemberCount> {
  Map<String, dynamic>? resData;
  List<String> group = List.empty(growable: true);
  getGroupOnlineMemberCount() async {
    ImValueCallback<int> res = await ImSDKPlugin.imManager
        .getGroupManager()
        .getGroupOnlineMemberCount(
          groupID: group.first,
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
              Expanded(
                child: ElevatedButton(
                  onPressed: getGroupOnlineMemberCount,
                  child: Text(imt("获取在线人数")),
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
