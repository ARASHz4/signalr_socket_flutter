//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_js/flutter_js_plugin.h>
#include <signalr_socket/signalr_socket_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flutter_js_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterJsPlugin");
  flutter_js_plugin_register_with_registrar(flutter_js_registrar);
  g_autoptr(FlPluginRegistrar) signalr_socket_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SignalrSocketPlugin");
  signalr_socket_plugin_register_with_registrar(signalr_socket_registrar);
}
