import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/friendSelector.dart';
import 'package:im_sdk_plugin_example/utils/sdkResponse.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class SendC2CCustomMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SendC2CCustomMessageState();
}

class SendC2CCustomMessageState extends State<SendC2CCustomMessage> {
  Map<String, dynamic>? resData;
  String customData = '';
  List<String> users = List.empty(growable: true);
  /*
  3.6.0 后已弃用建议不要使用
      var res =
        await ImSDKPlugin.imManager
            .getMessageManager()
            .sendCustomMessage(
                data: customData,
                receiver: users.length > 0 ? users.first : "",
                groupID: "");
  */

  sendC2CCustomMessage() async {
    var res = await ImSDKPlugin.imManager
        .getMessageManager()
        .sendCustomMessage(
            data: customData,
            receiver: users.length > 0 ? users.first : "",
            groupID: "");
    // 新版发送如下
    // ImValueCallback<ImMsgCreateInfoResult> createMessage =
    //     await ImSDKPlugin.imManager
    //         .getMessageManager()
    //         .createCustomMessage(data: customData);
    // String id = createMessage.data!.id!;
    // ImValueCallback<ImMessage> res =
    //     await ImSDKPlugin.imManager.getMessageManager().sendMessage(
    //           id: id,
    //           receiver: users.length > 0 ? users.first : "",
    //           groupID: "",
    //         );
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
                    labelText: imt("自定义数据"),
                    hintText: imt("自定义数据"),
                    prefixIcon: Icon(Icons.person),
                  ),
                  onChanged: (res) {
                    setState(() {
                      customData = res;
                    });
                  },
                ),
                new Row(
                  children: [
                    FriendSelector(
                      onSelect: (data) {
                        setState(() {
                          users = data;
                        });
                      },
                      switchSelectType: true,
                      value: users,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child:
                            Text(users.length > 0 ? users.toString() : imt("未选择")),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: sendC2CCustomMessage,
                  child: Text(imt("发送C2C自定义消息（弃用）")),
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
