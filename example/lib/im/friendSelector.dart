import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:im_sdk_plugin_example/utils/toast.dart';
import 'package:im_sdk_plugin/models/im_friend_info.dart';
import 'package:im_sdk_plugin/models/im_friend_info.dart';
import 'package:im_sdk_plugin/models/im_value_callback.dart';
import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

typedef OnSelect = Function(List<String> data);
typedef OnSelectItemChange = Function(String userID);

class FriendSelector extends StatefulWidget {
  final OnSelect onSelect;
  final bool switchSelectType;
  final List<String> value;
  const FriendSelector(
      {Key? key, required this.onSelect,
      this.switchSelectType = true,
      required this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FriendSelectorState();
}

class FriendItem extends StatefulWidget {
  final bool switchSelectType;
  final OnSelectItemChange onSelectItemChange;
  final ImFriendInfo info;
  final List<String> selected;
  const FriendItem(
    this.switchSelectType,
    this.info,
    this.selected, {Key? key, 
    required this.onSelectItemChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FriendItemState();
}

class FriendItemState extends State<FriendItem> {
  bool itemSelect = false;
  List<String> selected = List.empty(growable: true);
  @override
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
      if (widget.selected.isNotEmpty) {
        String selectedUserID = widget.selected.first;
        if (selectedUserID != userID) {
          Utils.toast(imt("单选只能选一个呀"));
          return;
        }
      }
    }
    if (data != null) {
      setState(() {
        itemSelect = data;
      });
    } else {
      setState(() {
        itemSelect = !itemSelect;
      });
    }
    widget.onSelectItemChange(userID);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            Expanded(
              child: Text("userID：${widget.info.userID}"),
            )
          ],
        ),
      ),
    );
  }
}

class FriendList extends StatefulWidget {
  final bool switchSelectType;
  final List<ImFriendInfo> users;
  final OnSelect onSelect;
  final List<String> value;
  const FriendList(this.switchSelectType, this.users, this.onSelect, this.value, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => FriendListState();
}

class FriendListState extends State<FriendList> {
  @override
  void initState() {
    super.initState();
    setState(() {
      selected = widget.value;
    });
  }

  List<String> selected = List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child:  ListView.builder(
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

class FriendSelectorState extends State<FriendSelector> {
  @override
  void initState() {
    super.initState();
    setState(() {
      selected = widget.value;
    });
  }
  
  List<String> selected = List.empty(growable: true);
  List<ImFriendInfo> friendList = List.empty();

  Future<ImFriendInfo?> getLoginUser() async {
    ImValueCallback<String> res =
        await ImSDKPlugin.imManager.getLoginUser();
    if (res.code != 0) {
      Utils.toastError(res.code, res.desc);
    } else {
      return ImFriendInfo(userID: res.data.toString());
    }
    return null;
  }

  Future<List<ImFriendInfo>?> getFriendList() async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    ImValueCallback<List<ImFriendInfo>> res = await ImSDKPlugin
        .imManager
        .getFriendshipManager()
        .getFriendList();
    ImFriendInfo? loginUserInfo = await getLoginUser();
    EasyLoading.dismiss();

    if (res.code != 0) {
      Utils.toastError(res.code, res.desc);
    } else {
      setState(() {
        if (loginUserInfo != null) {
          res.data?.add(loginUserInfo);
        }
        friendList = res.data!;
      });
      return res.data;
    }
    return [];
  }

  AlertDialog dialogShow(context) {
    final chooseType = (widget.switchSelectType ? imt(imt("单选")) : imt(imt("多选")));
    AlertDialog dialog = AlertDialog(
      title: Text("好友选择（$chooseType）"),
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
        List<ImFriendInfo>? fl = await getFriendList();
        if (fl != null) {
          if (fl.isNotEmpty) {
            showDialog<void>(
              context: context,
              builder: (context) => dialogShow(context),
            );
          } else {
            Utils.toast(imt("请先在好友关系链模块中添加好友"));
          }
        }
      },
      child: Text(imt("选择好友")),
    );
  }
}
