import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/friend_selector.dart';
import 'package:im_sdk_plugin_example/im/group_selector.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class SendTextMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SendTextMessageState();
}

class SendTextMessageState extends State<SendTextMessage> {
  Map<String, dynamic>? resData;
  String text = '';
  List<String> receiver = List.empty(growable: true);
  List<String> groupID = List.empty(growable: true);
  MessagePriorityEnum priority = MessagePriorityEnum.IM_PRIORITY_DEFAULT;
  bool onlineUserOnly = false;
  bool isExcludedFromUnreadCount = false;
  sendTextMessage() async {
    ImValueCallback<ImMsgCreateInfoResult> createMessage =
        await ImSDKPlugin.imManager
            .getMessageManager()
            .createTextMessage(text: text);
    String id = createMessage.data!.id!;

    ImValueCallback<ImMessage> res =
        await ImSDKPlugin.imManager.getMessageManager().sendMessage(
              id: id,
              receiver: receiver.isNotEmpty ? receiver.first : "",
              groupID: groupID.isNotEmpty ? groupID.first : "",
              priority: priority,
              onlineUserOnly: onlineUserOnly,
              isExcludedFromUnreadCount: isExcludedFromUnreadCount,
              localCustomData: imt("自定义localCustomData"),
              cloudCustomData: "",
              needReadReceipt: true,
              isSupportMessageExtension: true,
            );
    print(res.toJson());
    print("设置消息扩展");
    ImMessageExtension ext = ImMessageExtension(
        extensionKey: "test", extensionValue: "xingchenhe");
    ImValueCallback<List<ImMessageExtensionResult>> extreslres =
        await ImSDKPlugin.imManager
            .getMessageManager()
            .setMessageExtensions(
              msgID: res.data?.msgID ?? "",
              extensions: List.from([ext]),
            );
    print(extreslres.toJson());
    ext.extensionValue = "new xingchenhe";
    ImValueCallback<List<ImMessageExtensionResult>> extreslres1 =
        await ImSDKPlugin.imManager
            .getMessageManager()
            .setMessageExtensions(
              msgID: res.data?.msgID ?? "",
              extensions: List.from([ext]),
            );
    print(extreslres1.toJson());
    print("获取消息扩展");
    ImValueCallback<List<ImMessageExtension>> extlres =
        await ImSDKPlugin.imManager
            .getMessageManager()
            .getMessageExtensions(
              msgID: res.data?.msgID ?? "",
            );
    print(extlres.toJson());
    print("删除消息扩展");
    ImValueCallback<List<ImMessageExtensionResult>> extdelres =
        await ImSDKPlugin.imManager
            .getMessageManager()
            .deleteMessageExtensions(
      msgID: res.data?.msgID ?? "",
      keys: ["test"],
    );
    print(extdelres.toJson());
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
                child: TextField(
                  decoration: InputDecoration(
                    labelText: imt("发送文本"),
                    hintText: imt("文本内容"),
                    prefixIcon: Icon(Icons.person),
                  ),
                  onChanged: (res) {
                    setState(() {
                      text = res;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              FriendSelector(
                onSelect: (data) {
                  setState(() {
                    receiver = data;
                  });
                },
                switchSelectType: true,
                value: receiver,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                      receiver.length > 0 ? receiver.toString() : imt("未选择")),
                ),
              )
            ],
          ),
          Row(
            children: [
              GroupSelector(
                onSelect: (data) {
                  setState(() {
                    groupID = data;
                  });
                },
                switchSelectType: true,
                value: groupID,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                      groupID.length > 0 ? groupID.toString() : imt("未选择")),
                ),
              )
            ],
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black45,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      showAdaptiveActionSheet(
                        context: context,
                        title: Text(imt("优先级")),
                        actions: <BottomSheetAction>[
                          BottomSheetAction(
                            title: const Text('IM_PRIORITY_HIGH'),
                            onPressed: (context) {
                              setState(() {
                                priority =
                                    MessagePriorityEnum.IM_PRIORITY_HIGH;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          BottomSheetAction(
                            title: const Text('IM_PRIORITY_DEFAULT'),
                            onPressed: (context) {
                              setState(() {
                                priority =
                                    MessagePriorityEnum.IM_PRIORITY_DEFAULT;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          BottomSheetAction(
                            title: const Text('IM_PRIORITY_LOW'),
                            onPressed: (context) {
                              setState(() {
                                priority =
                                    MessagePriorityEnum.IM_PRIORITY_LOW;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          BottomSheetAction(
                            title: const Text('IM_PRIORITY_NORMAL'),
                            onPressed: (context) {
                              setState(() {
                                priority =
                                    MessagePriorityEnum.IM_PRIORITY_NORMAL;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ],
                        cancelAction: CancelAction(
                          title: const Text('Cancel'),
                        ), // onPressed parameter is optional by default will dismiss the ActionSheet
                      );
                    },
                    child: Text(imt("选择优先级")),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Text("已选：$priority"),
                )
              ],
            ),
          ),
          Row(
            children: [
              Text(imt("是否仅在线用户接受到消息")),
              Switch(
                value: onlineUserOnly,
                onChanged: (res) {
                  setState(() {
                    onlineUserOnly = res;
                  });
                },
              )
            ],
          ),
          Row(
            children: [
              Text(imt("发送消息是否不计入未读数")),
              Switch(
                value: isExcludedFromUnreadCount,
                onChanged: (res) {
                  setState(() {
                    isExcludedFromUnreadCount = res;
                  });
                },
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: sendTextMessage,
                  child: Text(imt("发送文本消息")),
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
