import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/friendSelector.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/models/im_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class MarkC2CMessageAsRead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MarkC2CMessageAsReadState();
}

class MarkC2CMessageAsReadState extends State<MarkC2CMessageAsRead> {
  Map<String, dynamic>? resData;
  List<String> users = List.empty(growable: true);
  markC2CMessageAsRead() async {
    ImCallback res = await ImSDKPlugin.imManager
        .getMessageManager()
        .markC2CMessageAsRead(
          userID: users.first,
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
              Expanded(
                child: ElevatedButton(
                  onPressed: markC2CMessageAsRead,
                  child: Text(imt("标记c2c会话已读")),
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
