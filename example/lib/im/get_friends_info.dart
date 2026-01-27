import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/friend_selector.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetFriendsInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetFriendsInfoState();
}

class GetFriendsInfoState extends State<GetFriendsInfo> {
  Map<String, dynamic>? resData;
  List<String> users = List.empty(growable: true);

  getFriendsInfo() async {
    ImValueCallback<List<ImFriendInfoResult>> res = await ImSDKPlugin.imManager
        .getFriendshipManager()
        .getFriendsInfo(userIDList: users);
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
                        child: Text(
                          users.length > 0 ? users.toString() : imt("未选择"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: getFriendsInfo,
                  child: Text(imt("获取好友信息")),
                ),
              ),
            ],
          ),
          SDKResponse(resData),
        ],
      ),
    );
  }
}
