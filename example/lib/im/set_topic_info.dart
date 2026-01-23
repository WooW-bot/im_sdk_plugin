import 'package:im_sdk_plugin/enums/group_add_opt_type.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';
import 'package:im_sdk_plugin_example/im/topic_selector.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:flutter/material.dart';

import 'package:im_sdk_plugin/models/im_topic_info.dart';

import 'community_selector.dart';

class SetTopicInfo extends StatefulWidget {
  const SetTopicInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SetTopicInfoState();
}

class _SetTopicInfoState extends State<SetTopicInfo> {
  String groupID = "";
  String topicID = "";
  String topicName = "";
  String topicFaceUrl = "";
  Map<String, dynamic>? resData;

  setTopicInfo() async {
    // final res = await ImSDKPlugin.imManager
    //     .getGroupManager()
    //     .setTopicInfo(
    //         groupID: groupID,
    //         topicInfo: ImTopicInfo(
    //             topicID: topicID,
    //             topicFaceUrl: topicFaceUrl,
    //             topicName: topicName.isNotEmpty ? topicName : null));
    final res = await ImSDKPlugin.imManager.getGroupManager().setGroupInfo(
      info: ImGroupInfo(
        groupID: groupID,
        notification: "",
        introduction: "",
        groupType: "Community",
        groupAddOpt: GroupAddOptType.IM_GROUP_ADD_ANY,
        faceUrl: "https://qcloudimg.tencent-cloud.cn/raw/0e6016322916215535ebde7440ddf67f.svg",
      ),
    );
    resData = res.toJson();
    setState(() {});
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
                  groupID = data.first;
                });
              },
              switchSelectType: true,
              value: groupID.isNotEmpty ? [groupID] : [],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(groupID.isNotEmpty ? groupID : imt("未选择")),
              ),
            ),
          ],
        ),
        Row(
          children: [
            TopicSelector(
              onSelect: (data) {
                setState(() {
                  topicID = data.first;
                });
              },
              groupID: groupID,
              switchSelectType: true,
              value: topicID.isNotEmpty ? [topicID] : [],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(topicID.isNotEmpty ? topicID : imt("未选择")),
              ),
            ),
          ],
        ),
        TextField(
          decoration: InputDecoration(
            labelText: imt("话题名称"),
            hintText: imt("话题名称"),
            prefixIcon: const Icon(Icons.person),
          ),
          onChanged: (res) {
            setState(() {
              topicName = res;
            });
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: imt("话题头像"),
            hintText: imt("话题头像"),
            prefixIcon: const Icon(Icons.person),
          ),
          onChanged: (res) {
            setState(() {
              topicFaceUrl = res;
            });
          },
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(onPressed: setTopicInfo, child: Text(imt("设置话题信息"))),
            ),
          ],
        ),
        SDKResponse(resData),
      ],
    );
  }
}
