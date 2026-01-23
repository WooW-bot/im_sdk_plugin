import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin/models/im_topic_info.dart';
import 'package:im_sdk_plugin/models/im_topic_info_result.dart';
import 'package:im_sdk_plugin/models/im_topic_operation_result.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

import '../utils/sdk_response.dart';

class CreateTopicInCommunity extends StatefulWidget {
  const CreateTopicInCommunity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CreateGroupState();
}

class CreateGroupState extends State<CreateTopicInCommunity> {
  Map<String, dynamic>? resData;

  String topicName = '';
  String groupID = '@TGS#_@TGS#cXNJ3HIM62CC';
  String notification = "";
  String introduction = "";
  String createdTopicId = "";

  // 3.6.0 后不建议使用简单方法创建群
  createGroup() async {
    ImValueCallback<String> res = await ImSDKPlugin.imManager.getGroupManager()
        .createTopicInCommunity(
          groupID: '@TGS#_@TGS#cXNJ3HIM62CC',
          topicInfo: ImTopicInfo.fromJson({
            "topicName": "Test topic",
            "notification": notification,
            "introduction": introduction,
          }),
        );
    setState(() {
      createdTopicId = res.data!;
      resData = res.toJson();
    });
  }

  deleteTopic() async {
    ImValueCallback<List<ImTopicOperationResult>> res =
        await ImSDKPlugin.imManager.getGroupManager().deleteTopicFromCommunity(
          groupID: '@TGS#_@TGS#cXNJ3HIM62CC',
          topicIDList: [createdTopicId],
        );
    setState(() {
      resData = res.toJson();
    });
  }

  updateTopic() async {
    ImCallback res = await ImSDKPlugin.imManager.getGroupManager().setTopicInfo(
      groupID: '@TGS#_@TGS#cXNJ3HIM62CC',
      topicInfo: ImTopicInfo.fromJson({
        "topicID": createdTopicId,
        "topicName": "updated topic",
        "notification": notification,
        "introduction": introduction,
      }),
    );
    // ImValueCallback<List<ImTopicOperationResult>> res =
    //     await ImSDKPlugin.imManager
    //         .getGroupManager()
    //         .deleteTopicFromCommunity(
    //             groupID: '@TGS#_@TGS#cXNJ3HIM62CC',
    //             topicIDList: [
    //       "@TGS#_@TGS#cXNJ3HIM62CC@TOPIC#_@TOPIC#cPOJ3HIM62CN"
    //     ]);

    setState(() {
      resData = res.toJson();
    });
  }

  getTopic() async {
    ImValueCallback<List<ImTopicInfoResult>> res = await ImSDKPlugin.imManager.getGroupManager()
        .getTopicInfoList(groupID: '@TGS#_@TGS#cXNJ3HIM62CC', topicIDList: []);
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
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: imt("群ID"),
                        hintText: imt("需要创建话题的社群ID"),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      onChanged: (res) {
                        setState(() {
                          groupID = res;
                        });
                      },
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
                        labelText: imt("notification"),
                        hintText: imt("notification"),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      onChanged: (res) {
                        setState(() {
                          notification = res;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: imt("简介"),
                        hintText: imt("简介"),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      onChanged: (res) {
                        setState(() {
                          introduction = res;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(onPressed: createGroup, child: Text(imt("创建话题"))),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(onPressed: getTopic, child: Text(imt("获取话题"))),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(onPressed: deleteTopic, child: Text(imt("删除话题"))),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(onPressed: updateTopic, child: Text(imt("更新话题"))),
            ),
          ],
        ),
        SDKResponse(resData),
      ],
    );
  }
}
