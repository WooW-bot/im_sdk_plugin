import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';
import 'package:im_sdk_plugin_example/im/friend_selector.dart';

import '../utils/sdk_response.dart';

class AddToBlackList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddToBlackListState();
}

class AddToBlackListState extends State<AddToBlackList> {
  Map<String, dynamic>? resData;
  List<String> users = List.empty(growable: true);
  addToBlackList() async {
    ImValueCallback<List<ImFriendOperationResult>> res =
        await ImSDKPlugin.imManager
            .getFriendshipManager()
            .addToBlackList(
              userIDList: users,
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
                      switchSelectType: false,
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
                  onPressed: addToBlackList,
                  child: Text(imt("添加到黑名单")),
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
