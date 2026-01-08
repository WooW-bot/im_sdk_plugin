#ifndef FLUTTER_PLUGIN_IM_SDK_PLUGIN_H_
#define FLUTTER_PLUGIN_IM_SDK_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace im_sdk_plugin {

class ImSdkPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  ImSdkPlugin();

  virtual ~ImSdkPlugin();

  // Disallow copy and assign.
  ImSdkPlugin(const ImSdkPlugin&) = delete;
  ImSdkPlugin& operator=(const ImSdkPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace im_sdk_plugin

#endif  // FLUTTER_PLUGIN_IM_SDK_PLUGIN_H_
