import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/groupSelector.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/models/im_group_info_result.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetGroupsInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetGroupsInfoState();
}

class GetGroupsInfoState extends State<GetGroupsInfo> {
  List<String> groupIDList = List.empty(growable: true);
  Map<String, dynamic>? resData;
  getGroupsInfo() async {
    // groupIDList.add("@TGS#_@TGS#cKGKWHIM62CT");
    ImValueCallback<List<ImGroupInfoResult>> res =
        await ImSDKPlugin.imManager
            .getGroupManager()
            .getGroupsInfo(groupIDList: groupIDList);
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
                    groupIDList = data;
                  });
                },
                switchSelectType: false,
                value: groupIDList,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                      groupIDList.length > 0 ? groupIDList.toString() : imt("未选择")),
                ),
              )
            ],
          ),
          new Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: getGroupsInfo,
                  child: Text(imt("获取群组信息")),
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
