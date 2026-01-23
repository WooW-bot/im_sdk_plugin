//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dynamic_color/dynamic_color_plugin.h>
#include <file_selector_linux/file_selector_plugin.h>
#include <im_sdk_core/im_sdk_core_plugin.h>
#include <im_sdk_plugin/im_sdk_plugin.h>
#include <record_linux/record_linux_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dynamic_color_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DynamicColorPlugin");
  dynamic_color_plugin_register_with_registrar(dynamic_color_registrar);
  g_autoptr(FlPluginRegistrar) file_selector_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FileSelectorPlugin");
  file_selector_plugin_register_with_registrar(file_selector_linux_registrar);
  g_autoptr(FlPluginRegistrar) im_sdk_core_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ImSdkCorePlugin");
  im_sdk_core_plugin_register_with_registrar(im_sdk_core_registrar);
  g_autoptr(FlPluginRegistrar) im_sdk_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ImSdkPlugin");
  im_sdk_plugin_register_with_registrar(im_sdk_plugin_registrar);
  g_autoptr(FlPluginRegistrar) record_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "RecordLinuxPlugin");
  record_linux_plugin_register_with_registrar(record_linux_registrar);
}
