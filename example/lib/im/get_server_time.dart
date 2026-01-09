import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class GetServerTime extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetServerTimeState();
}

class GetServerTimeState extends State<GetServerTime> {
  Map<String, dynamic>? resData;
  getServerTime() async {
    ImValueCallback<int> res =
        await ImSDKPlugin.imManager.getServerTime();
    setState(() {
      resData = res.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: getServerTime,
                  child: Text(imt("获取服务端时间")),
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
