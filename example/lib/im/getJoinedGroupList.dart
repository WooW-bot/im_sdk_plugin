import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/models/im_group_info.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetJoinedGroupList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetJoinedGroupListState();
}

class GetJoinedGroupListState extends State<GetJoinedGroupList> {
  Map<String, dynamic>? resData;
  getJoinedGroupList() async {
    ImValueCallback<List<ImGroupInfo>> res = await ImSDKPlugin
        .imManager
        .getGroupManager()
        .getJoinedGroupList();
    setState(() {
      resData = res.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          new Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: getJoinedGroupList,
                  child: Text(imt("获取加群列表")),
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
