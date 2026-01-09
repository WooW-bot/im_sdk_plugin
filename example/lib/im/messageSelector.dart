import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:im_sdk_plugin/models/im_conversation.dart';
import 'package:im_sdk_plugin/models/im_message.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';

typedef OnGet(List<String> data);

class MessageSelector extends StatefulWidget {
  final String conversationID;
  final List<String> values;
  final OnGet onSelect;
  MessageSelector(this.conversationID, this.values, this.onSelect);
  @override
  State<StatefulWidget> createState() => MessageSelectorState();
}

class MessageSelectorState extends State<MessageSelector> {
  List<String> timmessages = List.empty(growable: true);
  List<String> timmessageSelected = List.empty(growable: true);
  @override
  void initState() {
    super.initState();
  }

  getMessages() async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    ImValueCallback<ImConversation> res = await ImSDKPlugin
        .imManager
        .getConversationManager()
        .getConversation(
          conversationID: widget.conversationID,
        );
    late String? userID = res.data!.userID;
    String? groupID = res.data!.groupID;
    ImValueCallback<List<ImMessage>>? response;
    if (userID != null) {
      response = await ImSDKPlugin.imManager
          .getMessageManager()
          .getC2CHistoryMessageList(userID: userID, count: 20);
    }
    if (groupID != null) {
      response = await ImSDKPlugin.imManager
          .getMessageManager()
          .getGroupHistoryMessageList(groupID: groupID, count: 20);
    }
    List<ImMessage>? messageList =
        response == null ? List.empty() : response.data;
    EasyLoading.dismiss();
    List<String> messageIds = List.empty(growable: true);
    messageList!.forEach((element) {
      String? msgID = (element.msgID == null ? "" : element.msgID);
      messageIds.add(msgID!);
    });

    setState(() {
      timmessages = messageIds;
    });
    showDialog<void>(
      context: context,
      builder: (context) => dialogShow(context),
    );
  }

  AlertDialog dialogShow(context) {
    AlertDialog dialog = AlertDialog(
      title: Text(imt(imt("选择消息"))),
      contentPadding: EdgeInsets.zero,
      content: MemberList(
        timmessages,
        widget.values,
        (memberID) {
          if (timmessageSelected.contains(memberID)) {
            timmessageSelected.remove(memberID);
          } else {
            timmessageSelected.add(memberID);
          }
          widget.onSelect(timmessageSelected);
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(imt(imt("确认"))),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(imt(imt("取消"))),
        ),
      ],
    );
    return dialog;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(),
      child: Text(imt("选择消息")),
      onPressed: widget.conversationID == ''
          ? null
          : () {
              this.getMessages();
            },
    );
  }
}

class MemberList extends StatefulWidget {
  final List<String> members;
  final List<String> value;
  final Onselect onSelect;
  MemberList(this.members, this.value, this.onSelect);
  @override
  State<StatefulWidget> createState() => MemberListState();
}

class MemberListState extends State<MemberList> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: new ListView.builder(
        primary: true,
        shrinkWrap: true,
        itemCount: widget.members.length,
        itemBuilder: (context, index) {
          return MemberItem(widget.members[index], widget.value, (memberID) {
            widget.onSelect(memberID);
          });
        },
      ),
    );
  }
}

typedef Onselect(String memberID);

class MemberItem extends StatefulWidget {
  final String memberID;
  final List<String> selected;
  final Onselect onSelect;
  MemberItem(this.memberID, this.selected, this.onSelect);

  @override
  State<StatefulWidget> createState() => MemberItemState();
}

class MemberItemState extends State<MemberItem> {
  bool itemSelect = false;
  void initState() {
    super.initState();
    if (widget.selected.contains(widget.memberID)) {
      setState(() {
        itemSelect = true;
      });
    }
  }

  onItemTap([bool? data]) {
    if (data != null) {
      this.setState(() {
        itemSelect = data;
      });
    } else {
      this.setState(() {
        itemSelect = !itemSelect;
      });
    }
    widget.onSelect(widget.memberID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: InkWell(
        onTap: () {
          onItemTap();
        },
        child: Row(
          children: [
            Checkbox(
              value: itemSelect,
              onChanged: (data) {
                onItemTap(data);
              },
            ),
            Expanded(
              child: Text("messageID：${widget.memberID}"),
            )
          ],
        ),
      ),
    );
  }
}
