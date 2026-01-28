import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:im_sdk_plugin_example/utils/toast.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

import '../utils/toast.dart';

typedef OnSelect(List<String> data);
typedef OnSelectItemChange(String userID);

class FriendGroupSelector extends StatefulWidget {
  final OnSelect onSelect;
  final bool switchSelectType;
  final List<String> value;
  FriendGroupSelector({
    required this.onSelect,
    this.switchSelectType = true,
    required this.value,
  });

  @override
  State<StatefulWidget> createState() => FriendGroupSelectorState();
}

class FriendItem extends StatefulWidget {
  final bool switchSelectType;
  final OnSelectItemChange onSelectItemChange;
  final ImFriendGroup info;
  final List<String> selected;
  FriendItem(
    this.switchSelectType,
    this.info,
    this.selected, {
    required this.onSelectItemChange,
  });

  @override
  State<StatefulWidget> createState() => FriendItemState();
}

class FriendItemState extends State<FriendItem> {
  bool itemSelect = false;
  List<String> selected = List.empty(growable: true);
  void initState() {
    super.initState();
    setState(() {
      selected = widget.selected;
      itemSelect = widget.selected.contains(widget.info.name);
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
          onItemTap(widget.info.name!);
        },
        child: Row(
          children: [
            Checkbox(
              value: itemSelect,
              onChanged: (data) {
                onItemTap(widget.info.name!, data);
              },
            ),
            Expanded(child: Text("name：${widget.info.name}")),
          ],
        ),
      ),
    );
  }
}

class FriendList extends StatefulWidget {
  final bool switchSelectType;
  final List<ImFriendGroup> users;
  final OnSelect onSelect;
  final List<String> value;
  FriendList(this.switchSelectType, this.users, this.onSelect, this.value);
  @override
  State<StatefulWidget> createState() => FriendListState();
}

class FriendListState extends State<FriendList> {
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
          return FriendItem(
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

class FriendGroupSelectorState extends State<FriendGroupSelector> {
  void initState() {
    super.initState();
    setState(() {
      selected = widget.value;
    });
  }

  List<String> selected = List.empty(growable: true);
  List<ImFriendGroup> friendList = List.empty();

  Future<List<ImFriendGroup>?> getFriendList() async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    ImValueCallback<List<ImFriendGroup>> res = await ImSDKPlugin.imManager
        .getFriendshipManager()
        .getFriendGroups();
    EasyLoading.dismiss();
    if (!res.isSuccess) {
      Utils.toastError(res.code, res.msg);
    } else {
      setState(() {
        friendList = res.data!;
      });
      return res.data;
    }
    return null;
  }

  AlertDialog dialogShow(context) {
    final chooseType = (widget.switchSelectType
        ? imt(imt("单选"))
        : imt(imt("多选")));
    AlertDialog dialog = AlertDialog(
      title: Text("分组选择（$chooseType）"),
      contentPadding: EdgeInsets.zero,
      content: FriendList(widget.switchSelectType, friendList, (data) {
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
        List<ImFriendGroup>? fl = await this.getFriendList();
        if (fl != null) {
          if (fl.length > 0) {
            showDialog<void>(
              context: context,
              builder: (context) => dialogShow(context),
            );
          } else {
            Utils.toast(imt("请先在好友关系链模块中添加好友"));
          }
        }
      },
      child: Text(imt("选择分组")),
    );
  }
}
