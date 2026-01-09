import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/friendSelector.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/models/im_message.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class InsertC2CMessageToLocalStorage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InsertC2CMessageToLocalStorageState();
}

class InsertC2CMessageToLocalStorageState
    extends State<InsertC2CMessageToLocalStorage> {
  Map<String, dynamic>? resData;
  String? lastMsgID;
  List<String> users = List.empty(growable: true);
  List<String> senders = List.empty(growable: true);
  insertC2CMessageToLocalStorage() async {
    ImValueCallback<ImMessage> res = await ImSDKPlugin.imManager
        .getMessageManager()
        .insertC2CMessageToLocalStorage(
          userID: users.first,
          data: "test",
          sender: senders.first,
        );
    setState(() {
      resData = res.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    String userStr = users.length > 0 ? (users.isNotEmpty ? users.first : "") : imt("未选择");
    String senderStr = users.length > 0 ? (senders.isNotEmpty ? senders.first : "") : imt("未选择");
    return Container(
      child: Column(
        children: [
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FriendSelector(
                onSelect: (data) {
                  setState(() {
                    users = data;
                  });
                },
                switchSelectType: true,
                value: users,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("要查询的用户: $userStr"),
                ),
              )
            ],
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FriendSelector(
                onSelect: (data) {
                  setState(() {
                    senders = data;
                  });
                },
                switchSelectType: true,
                value: senders,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("要查询的用户: $senderStr"),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: insertC2CMessageToLocalStorage,
                  child: Text(imt("向c2c会话中插入一条本地消息")),
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
