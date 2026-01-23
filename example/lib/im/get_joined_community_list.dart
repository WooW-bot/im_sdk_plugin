import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetJoinedCommunitList extends StatefulWidget {
  const GetJoinedCommunitList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GetJoinedGroupListState();
}

class GetJoinedGroupListState extends State<GetJoinedCommunitList> {
  Map<String, dynamic>? resData;
  getJoinedGroupList() async {
    ImValueCallback<List<ImGroupInfo>> res = await ImSDKPlugin
        .imManager
        .getGroupManager()
        .getJoinedCommunityList();

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
            Expanded(
              child: ElevatedButton(
                onPressed: getJoinedGroupList,
                child: Text(imt("获取加入的社群列表")),
              ),
            )
          ],
        ),
        SDKResponse(resData),
      ],
    );
  }
}
