import 'dart:io';
import 'dart:typed_data';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/im/friend_selector.dart';
import 'package:im_sdk_plugin_example/im/group_selector.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';
import 'package:image_picker/image_picker.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';
import 'package:universal_html/html.dart' as html;

class SendImageMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SendImageMessageState();
}

class SendImageMessageState extends State<SendImageMessage> {
  Map<String, dynamic>? resData;
  List<String> receiver = List.empty(growable: true);
  List<String> groupID = List.empty(growable: true);
  MessagePriorityEnum priority = MessagePriorityEnum.IM_PRIORITY_DEFAULT;
  bool onlineUserOnly = false;
  bool isExcludedFromUnreadCount = false;
  File? image;
  Uint8List? fileContent;
  String? fileName;
  final picker = ImagePicker();

  sendImageMessage() async {
    html.Node? inputElem;
    if (kIsWeb) {
      inputElem = html.document
          .getElementById("__image_picker_web-file-input")
          ?.querySelector("input");
    }

    ImValueCallback<ImMsgCreateInfoResult> createMessage =
        await ImSDKPlugin.imManager.getMessageManager().createImageMessage(
          imagePath: image!.path,
          inputElement: inputElem,
        );
    String id = createMessage.data!.id!;

    ImValueCallback<ImMessage> res = await ImSDKPlugin.imManager.getMessageManager().sendMessage(
      id: id,
      receiver: receiver.length > 0 ? receiver.first : "",
      groupID: groupID.length > 0 ? groupID.first : "",
      priority: priority,
      onlineUserOnly: onlineUserOnly,
      isExcludedFromUnreadCount: isExcludedFromUnreadCount,
      localCustomData: imt("自定义localCustomData(sendImageMessage)"),
    );
    ImValueCallback<ImMessageOnlineUrl> ddd = await ImSDKPlugin.imManager.getMessageManager()
        .getMessageOnlineUrl(msgID: res.data!.msgID ?? "");
    ImCallback fff = await ImSDKPlugin.imManager.getMessageManager().downloadMessage(
      msgID: res.data!.msgID ?? "",
      imageType: 0,
      messageType: 1,
      isSnapshot: false,
    );
    print(ddd.toJson());
    setState(() {
      resData = res.toJson();
    });
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final imageContent = await pickedFile!.readAsBytes();
    final iamgeName = pickedFile.name;
    setState(() {
      image = File(pickedFile.path);
      fileContent = imageContent;
      fileName = iamgeName;
    });
  }

  Widget imageRender() {
    if (kIsWeb) {
      return Image.memory(fileContent!, width: 40, height: 40);
    }
    return Image.file(image!, width: 40, height: 40);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: ElevatedButton(onPressed: getImage, child: Text(imt("选择图片"))),
                margin: EdgeInsets.only(right: 12),
              ),
              image == null ? Text(imt(imt("未选择"))) : imageRender(),
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
                  child: Text(receiver.length > 0 ? receiver.toString() : imt("未选择")),
                ),
              ),
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
                  child: Text(groupID.length > 0 ? groupID.toString() : imt("未选择")),
                ),
              ),
            ],
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black45)),
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
                            title: const Text('IM_PRIORITY_DEFAULT'),
                            onPressed: (context) {
                              setState(() {
                                priority = MessagePriorityEnum.IM_PRIORITY_DEFAULT;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          BottomSheetAction(
                            title: const Text('IM_PRIORITY_HIGH'),
                            onPressed: (context) {
                              setState(() {
                                priority = MessagePriorityEnum.IM_PRIORITY_HIGH;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          BottomSheetAction(
                            title: const Text('IM_PRIORITY_LOW'),
                            onPressed: (context) {
                              setState(() {
                                priority = MessagePriorityEnum.IM_PRIORITY_LOW;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          BottomSheetAction(
                            title: const Text('IM_PRIORITY_NORMAL'),
                            onPressed: (context) {
                              setState(() {
                                priority = MessagePriorityEnum.IM_PRIORITY_NORMAL;
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
                Container(margin: EdgeInsets.only(left: 12), child: Text("已选：$priority")),
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
              ),
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
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: sendImageMessage, child: Text(imt("发送图片消息"))),
              ),
            ],
          ),
          SDKResponse(resData),
        ],
      ),
    );
  }
}
