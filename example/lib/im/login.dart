import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/config/config.dart';
import 'package:im_sdk_plugin_example/utils/generate_test_user_sig.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:localstorage/localstorage.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  final LocalStorage storage = new LocalStorage('package:im_sdk_plugin_example_user_info');
  Map<String, dynamic>? resData;

  login() async {
    String userID = /*storage.getItem("userID")*/ Config.userID;
    // 正式环境请在服务端计算userSIg
    String userSig = new GenerateTestUserSig(sdkappid: Config.sdkappid, key: Config.key).genSig(
      identifier: userID,
      expire: 7 * 24 * 60 * 1000, // userSIg有效期
    );
    ImValueCallback res = await ImSDKPlugin.imManager.login(userID: userID, userSig: userSig);
    // await ImSDKPlugin.imManager.callExperimentalAPI(api: "disableBadgeNumber", param: true);
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
                child: ElevatedButton(onPressed: login, child: Text(imt("登录"))),
              ),
            ],
          ),
          SDKResponse(resData),
        ],
      ),
    );
  }
}
