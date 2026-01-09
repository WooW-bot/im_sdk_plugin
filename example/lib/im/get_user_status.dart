import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/models/im_user_status.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetUserStatus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetUserStatusState();
}

class GetUserStatusState extends State<GetUserStatus> {
  Map<String, dynamic>? resData;
  getUserStatus() async {
    ImValueCallback<List<ImUserStatus>> res =
        await ImSDKPlugin.imManager.getUserStatus(userIDList: ['940928']);
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
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: getUserStatus,
                  child: Text(imt("获取用户在线状态")),
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
