#include "include/signalr_socket/signalr_socket_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "signalr_socket_plugin.h"

void SignalrSocketPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  signalr_socket::SignalrSocketPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
