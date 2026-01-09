import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetVersion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetVersionState();
}

class GetVersionState extends State<GetVersion> {
  Map<String, dynamic>? resData;
  getVersion() async {
    ImValueCallback<String> res =
        await ImSDKPlugin.imManager.getVersion();
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
                  onPressed: getVersion,
                  child: Text(imt("获取native sdk版本号")),
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
