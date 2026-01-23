import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';

import 'package:im_sdk_plugin/models/im_group_search_param.dart';

import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class SearchGroups extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchGroupsState();
}

class SearchGroupsState extends State<SearchGroups> {
  Map<String, dynamic>? resData;
  String text = '';
  List<String> receiver = List.empty(growable: true);
  List<String> groupID = List.empty(growable: true);
  int priority = 0;
  bool isSearchGroupID = false;
  bool isSearchGroupName = false;
  sendTextMessage() async {
    ImGroupSearchParam searchParam = new ImGroupSearchParam(
        keywordList: [text],
        isSearchGroupID: isSearchGroupID,
        isSearchGroupName: isSearchGroupName);

    ImValueCallback<List<ImGroupInfo>> res = await ImSDKPlugin
        .imManager
        .getGroupManager()
        .searchGroups(searchParam: searchParam);
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
                    labelText: imt("搜索关键字(最多支持五个，example只支持一个)"),
                    hintText: imt("关键字"),
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
              Text(imt("设置是否搜索群 ID")),
              Switch(
                value: isSearchGroupID,
                onChanged: (res) {
                  setState(() {
                    isSearchGroupID = res;
                  });
                },
              )
            ],
          ),
          Row(
            children: [
              Text(imt("设置是否搜索群名称")),
              Switch(
                value: isSearchGroupName,
                onChanged: (res) {
                  setState(() {
                    isSearchGroupName = res;
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
                  child: Text(imt("搜索Group")),
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
