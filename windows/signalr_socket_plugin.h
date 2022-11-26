#ifndef FLUTTER_PLUGIN_SIGNALR_SOCKET_PLUGIN_H_
#define FLUTTER_PLUGIN_SIGNALR_SOCKET_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace signalr_socket {

class SignalrSocketPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  SignalrSocketPlugin();

  virtual ~SignalrSocketPlugin();

  // Disallow copy and assign.
  SignalrSocketPlugin(const SignalrSocketPlugin&) = delete;
  SignalrSocketPlugin& operator=(const SignalrSocketPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace signalr_socket

#endif  // FLUTTER_PLUGIN_SIGNALR_SOCKET_PLUGIN_H_
