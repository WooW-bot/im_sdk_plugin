import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/group_selector.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/models/im_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class MarkGroupMessageAsRead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MarkGroupMessageAsReadState();
}

class MarkGroupMessageAsReadState extends State<MarkGroupMessageAsRead> {
  Map<String, dynamic>? resData;
  List<String> group = List.empty(growable: true);
  markGroupMessageAsRead() async {
    ImCallback res = await ImSDKPlugin.imManager
        .getMessageManager()
        .markGroupMessageAsRead(
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
              Expanded(
                child: ElevatedButton(
                  onPressed: markGroupMessageAsRead,
                  child: Text(imt("标记group会话已读")),
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
