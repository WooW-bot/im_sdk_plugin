import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class MarkAllMessageAsRead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MarkAllMessageAsReadState();
}

class MarkAllMessageAsReadState extends State<MarkAllMessageAsRead> {
  Map<String, dynamic>? resData;
  markAllMessageAsRead() async {
    // ImCallback res = await ImSDKPlugin.imManager
    //     .getMessageManager()
    //     .markAllMessageAsRead();
    // setState(() {
    //   resData = res.toJson();
    // });
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
                  onPressed: markAllMessageAsRead,
                  child: Text(imt("标记所有消息为已读")),
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
