import 'callbacks.dart';

/// 信令监听器
class ImSignalingListener {
  /// 收到新邀请
  OnReceiveNewInvitationCallback onReceiveNewInvitation =
      (String inviteID, String inviter, String groupID, List<String> inviteeList, String data) {};

  /// 被邀请者接受邀请
  OnInviteeAcceptedCallback onInviteeAccepted = (String inviteID, String invitee, String data) {};

  /// 被邀请者拒绝邀请
  OnInviteeRejectedCallback onInviteeRejected = (String inviteID, String invitee, String data) {};

  /// 邀请被取消
  OnInvitationCancelledCallback onInvitationCancelled =
      (String inviteID, String inviter, String data) {};

  /// 邀请超时
  OnInvitationTimeoutCallback onInvitationTimeout = (String inviteID, List<String> inviteeList) {};

  ImSignalingListener({
    OnReceiveNewInvitationCallback? onReceiveNewInvitation,
    OnInviteeAcceptedCallback? onInviteeAccepted,
    OnInviteeRejectedCallback? onInviteeRejected,
    OnInvitationCancelledCallback? onInvitationCancelled,
    OnInvitationTimeoutCallback? onInvitationTimeout,
  }) {
    if (onReceiveNewInvitation != null) {
      this.onReceiveNewInvitation = onReceiveNewInvitation;
    }
    if (onInviteeAccepted != null) {
      this.onInviteeAccepted = onInviteeAccepted;
    }
    if (onInviteeRejected != null) {
      this.onInviteeRejected = onInviteeRejected;
    }
    if (onInvitationCancelled != null) {
      this.onInvitationCancelled = onInvitationCancelled;
    }
    if (onInvitationTimeout != null) {
      this.onInvitationTimeout = onInvitationTimeout;
    }
  }
}
