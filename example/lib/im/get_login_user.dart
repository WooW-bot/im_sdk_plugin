import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetLoginUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetLoginUserState();
}

class GetLoginUserState extends State<GetLoginUser> {
  Map<String, dynamic>? resData;
  getLoginUser() async {
    ImValueCallback<String> res =
        await ImSDKPlugin.imManager.getLoginUser();
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
                  onPressed: getLoginUser,
                  child: Text(imt("获取当前登录用户")),
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
