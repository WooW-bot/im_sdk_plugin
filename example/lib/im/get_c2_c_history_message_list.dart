import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/friend_selector.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';


import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetC2CHistoryMessageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetC2CHistoryMessageListState();
}

class GetC2CHistoryMessageListState extends State<GetC2CHistoryMessageList> {
  Map<String, dynamic>? resData;
  String? lastMsgID;
  List<String> users = List.empty(growable: true);
  getC2CHistoryMessageList() async {
    ImValueCallback<List<ImMessage>> res = await ImSDKPlugin
        .imManager
        .getMessageManager()
        .getC2CHistoryMessageList(
          userID: users.first,
          count: 20,
          lastMsgID: lastMsgID,
        );
    setState(() {
      resData = res.toJson();
      if (res.data!.length > 0) {
        lastMsgID = res.data!.last.msgID;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Form(
            child: Column(
              children: <Widget>[
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
                        child:
                            Text(users.length > 0 ? users.toString() : imt("未选择")),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text("lastMessageID："),
              Expanded(
                child: Container(
                  height: 60,
                  margin: EdgeInsets.only(left: 12),
                  child: Text(lastMsgID == null ? '' : lastMsgID!),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: getC2CHistoryMessageList,
                  child: Text(imt("获取C2C历史消息")),
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
