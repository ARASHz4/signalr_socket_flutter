//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <signalr_socket/signalr_socket_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) signalr_socket_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SignalrSocketPlugin");
  signalr_socket_plugin_register_with_registrar(signalr_socket_registrar);
}
