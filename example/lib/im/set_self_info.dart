import 'dart:convert';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:im_sdk_plugin_example/utils/customerField/customer_field.dart';
import 'package:im_sdk_plugin_example/utils/sdk_response.dart';


import 'package:im_sdk_plugin/im_sdk_plugin.dart';
import 'package:im_sdk_plugin_example/i18n/i18n_utils.dart';

class SetSelfInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SetSelfInfoState();
}

class SetSelfInfoState extends State<SetSelfInfo> {
  String? nickname;
  String? faceUrl;
  String? selfSignature;
  int? gender;
  int? allowType;
  String? birthday;
  Map<String, String> customInfo = {"Str": "test custominfo 1222 r"};

  Map<String, dynamic>? resData;

  setSelfInfo() async {
    ImCallback res = await ImSDKPlugin.imManager.setSelfInfo(
      userFullInfo: ImUserFullInfo(
        nickName: nickname,
        faceUrl: faceUrl,
        selfSignature: selfSignature,
        gender: gender,
        friendAllowType: allowType,
        extra: customInfo.isNotEmpty ? json.encode(customInfo) : null,
        birthday: birthday,
      ),
    );
    setState(() {
      resData = res.toJson();
    });
  }

  onSetField(res) {
    setState(() {
      customInfo = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    String chooseType = (gender == 1
        ? imt(imt("男"))
        : gender == 2
        ? imt(imt("女"))
        : '');
    String chooseAllowType = (allowType == 0
        ? imt(imt("允许所有人加我好友"))
        : allowType == 1
        ? imt(imt("不允许所有人加我好友"))
        : allowType == 2
        ? imt(imt("加我好友许我确认"))
        : '');
    return Container(
      child: Column(
        children: [
          new Row(
            children: [
              Expanded(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: imt("昵称"),
                          hintText: "",
                          prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: (res) {
                          setState(() {
                            nickname = res;
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: imt("签名"),
                          hintText: imt("签名"),
                          prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: (res) {
                          setState(() {
                            selfSignature = res;
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: imt("生日(字符串 YYYY-MM-DD)"),
                          hintText: imt("生日"),
                          prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: (res) {
                          setState(() {
                            birthday = res;
                          });
                        },
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black45),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Icon(Icons.person, color: Colors.black45),
                              margin: EdgeInsets.only(left: 12),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: ElevatedButton(
                                onPressed: () {
                                  showAdaptiveActionSheet(
                                    context: context,
                                    title: Text(imt("性别")),
                                    actions: <BottomSheetAction>[
                                      BottomSheetAction(
                                        title: Text(imt("男")),
                                        onPressed: (context) {
                                          setState(() {
                                            gender = 1;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      BottomSheetAction(
                                        title: Text(imt("女")),
                                        onPressed: (context) {
                                          setState(() {
                                            gender = 2;
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
                                child: Text(imt("选择性别")),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text("已选：$chooseType"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black45),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Icon(Icons.person, color: Colors.black45),
                              margin: EdgeInsets.only(left: 12),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: ElevatedButton(
                                onPressed: () {
                                  showAdaptiveActionSheet(
                                    context: context,
                                    title: Text(imt("加好友验证方式")),
                                    actions: <BottomSheetAction>[
                                      BottomSheetAction(
                                        title: Text(imt("允许所有人加我好友")),
                                        onPressed: (context) {
                                          setState(() {
                                            allowType = 0;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      BottomSheetAction(
                                        title: Text(imt("加我好友需我确认")),
                                        onPressed: (context) {
                                          setState(() {
                                            allowType = 1;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      BottomSheetAction(
                                        title: Text(imt("不允许所有人加我好友")),
                                        onPressed: (context) {
                                          setState(() {
                                            allowType = 2;
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
                                child: Text(imt("加好友验证方式")),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text("已选：$chooseAllowType"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black45),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Icon(Icons.person, color: Colors.black45),
                              margin: EdgeInsets.only(left: 12),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: ElevatedButton(
                                onPressed: () {
                                  showAdaptiveActionSheet(
                                    context: context,
                                    title: Text(imt("头像")),
                                    actions: <BottomSheetAction>[
                                      BottomSheetAction(
                                        title: Image.network(
                                          "https://imgcache.qq.com/operation/dianshi/other/y2QNRn.efeeba9865fac2e6dbbeb8fafcc62a3d3cc1e0a6.png",
                                          width: 40,
                                          height: 40,
                                        ),
                                        onPressed: (context) {
                                          setState(() {
                                            faceUrl =
                                                'https://imgcache.qq.com/operation/dianshi/other/y2QNRn.efeeba9865fac2e6dbbeb8fafcc62a3d3cc1e0a6.png';
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      BottomSheetAction(
                                        title: Image.network(
                                          "https://imgcache.qq.com/operation/dianshi/other/vmuM7b.38bc8a9b478927da82ab0209773b5c8154d81469.jpeg",
                                          width: 40,
                                          height: 40,
                                        ),
                                        onPressed: (context) {
                                          setState(() {
                                            faceUrl =
                                                "https://imgcache.qq.com/operation/dianshi/other/vmuM7b.38bc8a9b478927da82ab0209773b5c8154d81469.jpeg";
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      BottomSheetAction(
                                        title: Image.network(
                                          "https://imgcache.qq.com/operation/dianshi/other/6vQ3U3.216b02313fa2374d2e44283490df64975712be5a.jpeg",
                                          width: 40,
                                          height: 40,
                                        ),
                                        onPressed: (context) {
                                          setState(() {
                                            faceUrl =
                                                "https://imgcache.qq.com/operation/dianshi/other/6vQ3U3.216b02313fa2374d2e44283490df64975712be5a.jpeg";
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      BottomSheetAction(
                                        title: Image.network(
                                          "https://imgcache.qq.com/operation/dianshi/other/jYNR3e.909696a6a93a853a056bf71da21f8938a906d6f3.png",
                                          width: 40,
                                          height: 40,
                                        ),
                                        onPressed: (context) {
                                          setState(() {
                                            faceUrl =
                                                "https://imgcache.qq.com/operation/dianshi/other/jYNR3e.909696a6a93a853a056bf71da21f8938a906d6f3.png";
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
                                child: Text(imt("选择头像")),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: faceUrl != ''
                                  ? Image.network(
                                      faceUrl ?? "",
                                      width: 40,
                                      height: 40,
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                      CustomerField(onSetField: onSetField, maxSetCount: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          new Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: setSelfInfo,
                  child: Text(imt("设置个人信息")),
                ),
              ),
            ],
          ),
          SDKResponse(resData),
        ],
      ),
    );
  }
}
