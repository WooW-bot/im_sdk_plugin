import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/groupMemberSelector.dart';
import 'package:im_sdk_plugin_example/im/groupSelector.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/models/im_message.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class InsertGroupMessageToLocalStorage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      InsertGroupMessageToLocalStorageState();
}

class InsertGroupMessageToLocalStorageState
    extends State<InsertGroupMessageToLocalStorage> {
  Map<String, dynamic>? resData;
  String? lastMsgID;
  List<String> group = List.empty(growable: true);
  List<String> members = List.empty(growable: true);
  insertGroupMessageToLocalStorage() async {
    ImValueCallback<ImMessage> res = await ImSDKPlugin.imManager
        .getMessageManager()
        .insertGroupMessageToLocalStorage(
          groupID: group.first,
          data: "test",
          sender: members.first,
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
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                members,
                (data) {
                  setState(() {
                    members = data;
                  });
                },
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Text(
                      "sender: ${members.isNotEmpty ? members.first : ""}"),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: insertGroupMessageToLocalStorage,
                  child: Text(imt("向group中插入一条本地消息")),
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
