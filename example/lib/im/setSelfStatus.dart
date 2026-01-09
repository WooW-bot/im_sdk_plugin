import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/models/im_callback.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class SetSelfStatus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SetSelfStatusState();
}

class SetSelfStatusState extends State<SetSelfStatus> {
  Map<String, dynamic>? resData;
  setSelfStatus() async {
    ImCallback res =
        await ImSDKPlugin.imManager.setSelfStatus(status: "梦游中..");
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
                  onPressed: setSelfStatus,
                  child: Text(imt("设置个人状态")),
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
