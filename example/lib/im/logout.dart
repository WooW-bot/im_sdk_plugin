import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class Logout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogoutState();
}

class LogoutState extends State<Logout> {
  logout() async {
    ImSDKPlugin.imManager.logout();
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
                  onPressed: logout,
                  child: Text(imt("登出")),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
