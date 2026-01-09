import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetLoginStatus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetLoginStatusState();
}

class GetLoginStatusState extends State<GetLoginStatus> {
  Map<String, dynamic>? resData;
  getLoginStatus() async {
    ImValueCallback<int> res =
        await ImSDKPlugin.imManager.getLoginStatus();
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
                  onPressed: getLoginStatus,
                  child: Text(imt("获取当前登录状态")),
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
