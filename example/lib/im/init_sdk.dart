import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/config/config.dart';
import 'package:im_sdk_plugin_example/provider/event.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:im_sdk_plugin/listener/im_sdk_listener.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class InitSDK extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitSDKState();
}

class InitSDKState extends State<InitSDK> {
  final LocalStorage storage = new LocalStorage('package:im_sdk_plugin_example_user_info');

  Map<String, dynamic>? resData;

  initIMSDK() async {
    ImValueCallback<bool> res = await ImSDKPlugin.imManager.initSDK(
      appID: Config.sdkappid.toString(),
      logLevel: LogLevel.IM_LOG_ALL,
      showImLog: true,
      listener: new ImSDKListener(
        onConnectFailed: Provider.of<Event>(context, listen: false).onConnectFailed,
        onConnectSuccess: Provider.of<Event>(context, listen: false).onConnectSuccess,
        onConnecting: Provider.of<Event>(context, listen: false).onConnectSuccess,
        onKickedOffline: Provider.of<Event>(context, listen: false).onKickedOffline,
        onSelfInfoUpdated: Provider.of<Event>(context, listen: false).onSelfInfoUpdated,
        onUserSigExpired: Provider.of<Event>(context, listen: false).onUserSigExpired,
        onUserStatusChanged: Provider.of<Event>(context, listen: false).onUserStatusChanged,
        onLog: (logLevel, logContent) {
          print("$logLevel $logContent");
        },
      ),
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
          new Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: initIMSDK, child: Text(imt("初始化"))),
              ),
            ],
          ),
          SDKResponse(resData),
        ],
      ),
    );
  }
}
