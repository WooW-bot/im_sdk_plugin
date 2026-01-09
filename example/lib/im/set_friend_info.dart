import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/friend_selector.dart';
import 'package:im_sdk_plugin_example/utils/customerField/customer_field.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/models/im_callback.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';

class SetFriendInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SetFriendInfoState();
}

class SetFriendInfoState extends State<SetFriendInfo> {
  String nickname = '';
  String faceUrl = '';
  String selfSignature = "";
  int? gender;
  int? allowType;
  Map<String, String>? customInfo;
  List<String> users = List.empty(growable: true);
  String? friendRemark;
  Map<String, dynamic>? resData;
  setFriendInfo() async {
    ImCallback res = await ImSDKPlugin.imManager
        .getFriendshipManager()
        .setFriendInfo(
            friendRemark: friendRemark,
            userID: users.first,
            friendCustomInfo: customInfo);
    setState(() {
      resData = res.toJson();
    });
  }

  onSetField(Map<String, String> res) {
    setState(() {
      customInfo = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
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
                  child: Text(users.length > 0 ? users.toString() : imt("未选择")),
                ),
              )
            ],
          ),
          new Row(
            children: [
              Expanded(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: imt("好友备注"),
                          hintText: imt("好友备注"),
                          prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: (res) {
                          setState(() {
                            friendRemark = res;
                          });
                        },
                      ),
                      CustomerField(
                        onSetField: onSetField,
                        maxSetCount: 20,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          new Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: setFriendInfo,
                  child: Text(imt("设置好友信息")),
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
