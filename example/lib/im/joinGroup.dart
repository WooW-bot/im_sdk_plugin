import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/models/im_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class JoinGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => JoinGroupState();
}

class JoinGroupState extends State<JoinGroup> {
  Map<String, dynamic>? resData;
  String groupID = '';
  late String message;
  joinGroup() async {
    ImCallback res = await ImSDKPlugin.imManager.joinGroup(
      groupID: "@TGS#_@TGS#cXNJ3HIM62CC",
      message: message,
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
          Form(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: imt("群ID"),
                    hintText: imt("群ID"),
                    prefixIcon: Icon(Icons.person),
                  ),
                  onChanged: (res) {
                    setState(() {
                      groupID = res;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: imt("进群打招呼Message"),
                    hintText: imt("进群打招呼Message"),
                    prefixIcon: Icon(Icons.person),
                  ),
                  onChanged: (res) {
                    setState(() {
                      message = res;
                    });
                  },
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: joinGroup,
                  child: Text(imt("加入群组")),
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
