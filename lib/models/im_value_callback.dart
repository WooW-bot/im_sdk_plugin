import 'login_model.dart';
import 'im_conversation.dart';
import 'im_conversation_operation_result.dart';
import 'im_conversation_result.dart';
import 'im_friend_application_result.dart';
import 'im_friend_check_result.dart';
import 'im_friend_group.dart';
import 'im_friend_info.dart';
import 'im_friend_info_result.dart';
import 'im_friend_operation_result.dart';
import 'im_group_application_result.dart';
import 'im_group_info.dart';
import 'im_group_info_result.dart';
import 'im_group_member_full_info.dart';
import 'im_group_member_info_result.dart';
import 'im_group_member_operation_result.dart';
import 'im_group_member_search_result.dart';
import 'im_group_message_read_member_list.dart';
import 'im_message.dart';
import 'im_message_change_info.dart';
import 'im_message_extension.dart';
import 'im_message_extension_result.dart';
import 'im_message_list_result.dart';
import 'im_message_online_url.dart';
import 'im_message_receipt.dart';
import 'im_message_search_result.dart';
import 'im_msg_create_info_result.dart';
import 'im_receive_message_opt_info.dart';
import 'im_signaling_info.dart';
import 'im_topic_info_result.dart';
import 'im_topic_operation_result.dart';
import 'im_user_full_info.dart';
import 'im_user_status.dart';
import 'sync_response.dart';

class ImValueCallback<T> {
  /// 错误码
  late int code;

  /// 错误描述
  late String msg;

  /// 数据
  T? data;

  ImValueCallback({required this.code, required this.msg, this.data});

  bool get isSuccess => code == 200;

  static ImValueCallback<T> success<T>({T? data, String msg = "success"}) {
    return ImValueCallback<T>(code: 200, msg: msg, data: data);
  }

  static ImValueCallback<T> error<T>({
    int code = -1,
    String msg = "Unknown Error",
    T? data,
  }) {
    return ImValueCallback<T>(code: code, msg: msg, data: data);
  }

  _getT<T>() => T;

  ImValueCallback.fromJson(Map<String, dynamic> json) {
    late dynamic fromJsonData;
    if (json['data'] == null) {
      fromJsonData = data;
    } else {
      if (T == ImMessage) {
        fromJsonData = ImMessage.fromJson(json['data']) as T;
      } else if (T == ImUserFullInfo) {
        fromJsonData = ImUserFullInfo.fromJson(json['data']) as T;
      } else if (T == _getT<List<ImUserFullInfo>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImUserFullInfo.fromJson(e);
                }).toList()
                as T;
      } else if (T == RouteInfo) {
        fromJsonData = RouteInfo.fromJson(json['data']) as T;
      } else if (T == _getT<List<ImGroupInfo>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImGroupInfo.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImGroupInfoResult>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImGroupInfoResult.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<Map<String, String>>()) {
        fromJsonData = Map<String, String>.from(json['data']) as T;
      } else if (T == ImGroupMemberInfoResult) {
        fromJsonData = ImGroupMemberInfoResult.fromJson(json['data']) as T;
      } else if (T == _getT<List<ImGroupMemberFullInfo>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImGroupMemberFullInfo.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImGroupMemberOperationResult>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImGroupMemberOperationResult.fromJson(e);
                }).toList()
                as T;
      } else if (T == ImGroupApplicationResult) {
        fromJsonData = ImGroupApplicationResult.fromJson(json['data']) as T;
      } else if (T == ImConversationResult) {
        fromJsonData = ImConversationResult.fromJson(json['data']) as T;
      } else if (T == ImConversation) {
        fromJsonData = ImConversation.fromJson(json['data']) as T;
      } else if (T == _getT<List<ImFriendInfo>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImFriendInfo.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImFriendInfoResult>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImFriendInfoResult.fromJson(e);
                }).toList()
                as T;
      } else if (T == ImFriendOperationResult) {
        fromJsonData = ImFriendOperationResult.fromJson(json['data']) as T;
      } else if (T == _getT<List<ImFriendOperationResult>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImFriendOperationResult.fromJson(e);
                }).toList()
                as T;
      } else if (T == ImFriendCheckResult) {
        fromJsonData = ImFriendCheckResult.fromJson(json['data']) as T;
      } else if (T == ImConversationOperationResult) {
        fromJsonData =
            ImConversationOperationResult.fromJson(json['data']) as T;
      } else if (T == _getT<List<ImFriendCheckResult>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImFriendCheckResult.fromJson(e);
                }).toList()
                as T;
      } else if (T == ImFriendApplicationResult) {
        fromJsonData = ImFriendApplicationResult.fromJson(json['data']) as T;
      } else if (T == _getT<List<ImFriendGroup>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImFriendGroup.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImMessage>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImMessage.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImMessageExtensionResult>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImMessageExtensionResult.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImMessageExtension>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImMessageExtension.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImConversation>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImConversation.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImReceiveMessageOptInfo>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImReceiveMessageOptInfo.fromJson(e);
                }).toList()
                as T;
      } else if (T == ImMessageSearchResult) {
        fromJsonData = ImMessageSearchResult.fromJson(json['data']) as T;
      } else if (T == GroupMemberInfoSearchResult) {
        fromJsonData = GroupMemberInfoSearchResult.fromJson(
          json['data'],
        ); // ImSignalingInfo
      } else if (T == ImSignalingInfo) {
        fromJsonData = ImSignalingInfo.fromJson(json['data']);
      } else if (T == ImMessageListResult) {
        fromJsonData = ImMessageListResult.fromJson(json['data']);
      } else if (T == ImMessageOnlineUrl) {
        fromJsonData = ImMessageOnlineUrl.fromJson(json['data']);
      } else if (T == ImMessageChangeInfo) {
        fromJsonData = ImMessageChangeInfo.fromJson(json['data']);
      } else if (T == ImMsgCreateInfoResult) {
        fromJsonData = ImMsgCreateInfoResult.fromJson(json['data']);
      } else if (T == ImGroupMessageReadMemberList) {
        fromJsonData = ImGroupMessageReadMemberList.fromJson(json['data']);
      } else if (T == _getT<List<ImMessageReceipt>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImMessageReceipt.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImTopicInfoResult>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImTopicInfoResult.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImTopicOperationResult>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImTopicOperationResult.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImGroupInfo>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImGroupInfo.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImUserStatus>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImUserStatus.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<List<ImConversationOperationResult>>()) {
        fromJsonData =
            (json['data'] as List).map((e) {
                  return ImConversationOperationResult.fromJson(e);
                }).toList()
                as T;
      } else if (T == _getT<SyncResponse<ImFriendInfo>>()) {
        // Explicitly handle SyncResponse<ImFriendInfo>
        fromJsonData =
            SyncResponse<ImFriendInfo>.fromJson(
                  json['data'],
                  (v) => ImFriendInfo.fromJson(v),
                )
                as T;
      } else if (T == _getT<List<String>>()) {
        fromJsonData = List.from(
          json["data"],
        ).map((e) => e.toString()).toList();
      } else {
        fromJsonData = json['data'] as T;
      }
    }

    code = json['code'] ?? -1;
    msg = json['msg'] ?? '';
    data = fromJsonData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    dynamic toJsonData = this.data;
    if (this.data == null) {
      data['data'] = this.data;
    } else {
      if (T == ImMessage) {
        toJsonData = (this.data as ImMessage).toJson();
      } else if (T == RouteInfo) {
        toJsonData = (this.data as RouteInfo).toJson();
      } else if (T == ImMessageListResult) {
        toJsonData = (this.data as ImMessageListResult).toJson();
      } else if (T == ImUserFullInfo) {
        toJsonData = (this.data as ImUserFullInfo).toJson();
      } else if (T == _getT<List<ImUserFullInfo>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImUserFullInfo).toJson())
            .toList();
      } else if (T == _getT<List<ImGroupInfo>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImGroupInfo).toJson())
            .toList();
      } else if (T == _getT<List<ImGroupInfoResult>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImGroupInfoResult).toJson())
            .toList();
      } else if (T == _getT<Map<String, String>>()) {
        toJsonData = this.data as Map<String, String>;
      } else if (T == ImGroupMemberInfoResult) {
        toJsonData = (this.data as ImGroupMemberInfoResult).toJson();
      } else if (T == _getT<List<ImGroupMemberFullInfo>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImGroupMemberFullInfo).toJson())
            .toList();
      } else if (T == _getT<List<ImGroupMemberOperationResult>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImGroupMemberOperationResult).toJson())
            .toList();
      } else if (T == ImGroupApplicationResult) {
        toJsonData = (this.data as ImGroupApplicationResult).toJson();
      } else if (T == ImConversation) {
        toJsonData = (this.data as ImConversation).toJson();
      } else if (T == ImConversationResult) {
        toJsonData = (this.data as ImConversationResult).toJson();
      } else if (T == _getT<List<ImFriendInfo>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImFriendInfo).toJson())
            .toList();
      } else if (T == _getT<List<ImFriendInfoResult>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImFriendInfoResult).toJson())
            .toList();
      } else if (T == ImFriendOperationResult) {
        toJsonData = (this.data as ImFriendOperationResult).toJson();
      } else if (T == _getT<List<ImFriendOperationResult>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImFriendOperationResult).toJson())
            .toList();
      } else if (T == ImFriendCheckResult) {
        toJsonData = (this.data as ImFriendCheckResult).toJson();
      } else if (T == _getT<List<ImFriendCheckResult>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImFriendCheckResult).toJson())
            .toList();
      } else if (T == ImFriendApplicationResult) {
        toJsonData = (this.data as ImFriendApplicationResult).toJson();
      } else if (T == _getT<List<ImFriendGroup>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImFriendGroup).toJson())
            .toList();
      } else if (T == _getT<List<ImMessage>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImMessage).toJson())
            .toList();
      } else if (T == _getT<List<ImMessageExtensionResult>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImMessageExtensionResult).toJson())
            .toList();
      } else if (T == _getT<List<ImMessageExtension>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImMessageExtension).toJson())
            .toList();
      } else if (T == ImMessageSearchResult) {
        toJsonData = (this.data as ImMessageSearchResult).toJson();
      } else if (T == ImMessageOnlineUrl) {
        toJsonData = (this.data as ImMessageOnlineUrl).toJson();
      } else if (T == ImSignalingInfo) {
        toJsonData = (this.data as ImSignalingInfo).toJson();
      } else if (T == ImMsgCreateInfoResult) {
        toJsonData = (this.data as ImMsgCreateInfoResult).toJson();
      } else if (T == ImMessageChangeInfo) {
        toJsonData = (this.data as ImMessageChangeInfo).toJson();
      } else if (T == ImConversationOperationResult) {
        toJsonData = (this.data as ImConversationOperationResult).toJson();
      } else if (T == ImGroupMessageReadMemberList) {
        toJsonData = (this.data as ImGroupMessageReadMemberList).toJson();
      } else if (T == _getT<List<ImMessageReceipt>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImMessageReceipt).toJson())
            .toList();
      } else if (T == _getT<List<ImTopicInfoResult>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImTopicInfoResult).toJson())
            .toList();
      } else if (T == _getT<List<ImTopicOperationResult>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImTopicOperationResult).toJson())
            .toList();
      } else if (T == _getT<List<ImGroupInfo>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImGroupInfo).toJson())
            .toList();
      } else if (T == _getT<List<ImUserStatus>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImUserStatus).toJson())
            .toList();
      } else if (T == _getT<List<ImConversationOperationResult>>()) {
        toJsonData = (this.data as List)
            .map((e) => (e as ImConversationOperationResult).toJson())
            .toList();
      } else if (T == _getT<SyncResponse<ImFriendInfo>>()) {
        toJsonData = (this.data as SyncResponse<ImFriendInfo>).toJson(
          (v) => v.toJson(),
        );
      } else {
        toJsonData = this.data;
      }
      data['data'] = toJsonData;
    }
    return data;
  }
}
