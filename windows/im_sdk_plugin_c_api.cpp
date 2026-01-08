#include "include/im_sdk_plugin/im_sdk_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "im_sdk_plugin.h"

void ImSdkPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  im_sdk_plugin::ImSdkPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
