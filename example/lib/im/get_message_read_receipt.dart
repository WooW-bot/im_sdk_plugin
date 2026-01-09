import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:flutter/material.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';

class GetMessageReadReceipt extends StatefulWidget {
  const GetMessageReadReceipt({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GetMessageReadReceiptState();
}

class _GetMessageReadReceiptState extends State<GetMessageReadReceipt> {
  final messageID = "144115235149692122-1663296849-43057331";
  Map<String, dynamic>? resData;
  getMessageReadReceipt() async {
    final res = await ImSDKPlugin.imManager
        .getMessageManager()
        .getMessageReadReceipts(messageIDList: [messageID]);
    resData = res.toJson();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: getMessageReadReceipt,
                child: Text(imt("获取已读消息列表")),
              ),
            )
          ],
        ),
        SDKResponse(resData),
      ],
    );
  }
}
