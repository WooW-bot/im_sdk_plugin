import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/group_selector.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/models/im_message.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetGroupHistoryMessageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetGroupHistoryMessageListState();
}

class GetGroupHistoryMessageListState
    extends State<GetGroupHistoryMessageList> {
  Map<String, dynamic>? resData;
  String? lastMsgID;
  List<String> group = List.empty(growable: true);
  getGroupHistoryMessageList() async {
    ImValueCallback<List<ImMessage>> res = await ImSDKPlugin
        .imManager
        .getMessageManager()
        .getGroupHistoryMessageList(
          groupID: group.first,
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
                        child:
                            Text(group.length > 0 ? group.toString() : imt("未选择")),
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
                  onPressed: getGroupHistoryMessageList,
                  child: Text(imt("获取Group历史消息")),
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
