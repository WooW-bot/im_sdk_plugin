import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

import '../utils/sdkResponse.dart';

class CheckAbility extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CheckAbilityState();
}

class CheckAbilityState extends State<CheckAbility> {
  Map<String, dynamic>? resData;

  checkAbility() async {
    ImValueCallback<int> res = await ImSDKPlugin.imManager.checkAbility();

    setState(() {
      resData = res.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(onPressed: checkAbility, child: Text(imt("检测能力位"))),
            ),
          ],
        ),
        SDKResponse(resData),
      ],
    );
  }
}
