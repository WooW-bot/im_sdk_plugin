import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin/models/im_friend_application.dart';
import 'package:im_sdk_plugin/models/im_friend_application_result.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

import '../utils/toast.dart';

typedef OnSelect(List<String> data);
typedef OnSelectItemChange(String userID);

class FriendApplicationSelector extends StatefulWidget {
  final OnSelect onSelect;
  final bool switchSelectType;
  final List<String> value;

  FriendApplicationSelector({
    required this.onSelect,
    this.switchSelectType = true,
    required this.value,
  });

  @override
  State<StatefulWidget> createState() => FriendApplicationSelectorState();
}

class FriendApplicationItem extends StatefulWidget {
  final bool switchSelectType;
  final OnSelectItemChange onSelectItemChange;
  final ImFriendApplication info;
  final List<String> selected;

  FriendApplicationItem(
    this.switchSelectType,
    this.info,
    this.selected, {
    required this.onSelectItemChange,
  });

  @override
  State<StatefulWidget> createState() => FriendItemState();
}

class FriendItemState extends State<FriendApplicationItem> {
  bool itemSelect = false;
  List<String> selected = List.empty(growable: true);

  void initState() {
    super.initState();
    setState(() {
      selected = widget.selected;
      itemSelect = widget.selected.contains(widget.info.userID);
    });
  }

  onItemTap(String userID, [bool? data]) {
    if (widget.switchSelectType) {
      // 单选
      if (widget.selected.length > 0) {
        String selectedUserID = widget.selected.first;
        if (selectedUserID != userID) {
          Utils.toast(imt("单选只能选一个呀"));
          return;
        }
      }
    }
    if (data != null) {
      this.setState(() {
        itemSelect = data;
      });
    } else {
      this.setState(() {
        itemSelect = !itemSelect;
      });
    }
    widget.onSelectItemChange(userID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: InkWell(
        onTap: () {
          onItemTap(widget.info.userID);
        },
        child: Row(
          children: [
            Checkbox(
              value: itemSelect,
              onChanged: (data) {
                onItemTap(widget.info.userID, data);
              },
            ),
            Expanded(child: Text("userID：${widget.info.userID}")),
          ],
        ),
      ),
    );
  }
}

class FriendApplicationList extends StatefulWidget {
  final bool switchSelectType;
  final List<ImFriendApplication> users;
  final OnSelect onSelect;
  final List<String> value;

  FriendApplicationList(this.switchSelectType, this.users, this.onSelect, this.value);

  @override
  State<StatefulWidget> createState() => FriendApplicationListState();
}

class FriendApplicationListState extends State<FriendApplicationList> {
  void initState() {
    super.initState();
    setState(() {
      selected = widget.value;
    });
  }

  List<String> selected = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: new ListView.builder(
        primary: true,
        shrinkWrap: true,
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          return FriendApplicationItem(
            widget.switchSelectType,
            widget.users[index],
            selected,
            onSelectItemChange: (userID) {
              if (selected.contains(userID)) {
                selected.remove(userID);
              } else {
                selected.add(userID);
              }
              widget.onSelect(selected);
            },
          );
        },
      ),
    );
  }
}

class FriendApplicationSelectorState extends State<FriendApplicationSelector> {
  void initState() {
    super.initState();
    setState(() {
      selected = widget.value;
    });
  }

  List<String> selected = List.empty(growable: true);
  List<ImFriendApplication?> friendList = List.empty();

  Future<List<ImFriendApplication?>?> getApplicationList() async {
    await EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    ImValueCallback<ImFriendApplicationResult> res =
        await ImSDKPlugin.imManager.getFriendshipManager().getFriendApplicationList();

    EasyLoading.dismiss();

    if (res.code != 0) {
      Utils.toastError(res.code, res.desc);
    } else {
      List<ImFriendApplication?> friendApplication = res.data?.friendApplicationList ?? [];
      setState(() {
        friendList = friendApplication;
      });
      return res.data?.friendApplicationList ?? [];
    }
    return null;
  }

  // 弹窗了
  AlertDialog dialogShow(context, applicationTransferList) {
    final chooseType = (widget.switchSelectType ? imt(imt("单选")) : imt(imt("多选")));
    AlertDialog dialog = AlertDialog(
      title: Text("好友申请选择（$chooseType）"),
      contentPadding: EdgeInsets.zero,
      content: FriendApplicationList(widget.switchSelectType, applicationTransferList, (data) {
        setState(() {
          selected = data;
        });
      }, selected),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onSelect(selected);
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
      onPressed: () async {
        List<ImFriendApplication?>? fl = await this.getApplicationList();
        if (fl != null) {
          if (fl.length > 0) {
            // 如果有这种很沙雕的类型转换，尤其是碰到这种数组判空
            List<ImFriendApplication> applicationTransferList = [];
            fl.forEach((item) => {applicationTransferList.add(item!)});
            showDialog<void>(
              context: context,
              builder: (context) => dialogShow(context, applicationTransferList),
            );
          } else {
            Utils.toast(imt("目前没有好友申请"));
          }
        }
      },
      child: Text(imt("选择好友申请")),
    );
  }
}
