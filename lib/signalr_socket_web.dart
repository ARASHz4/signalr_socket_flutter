// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';
import 'package:signalr_socket/signalr_socket.dart';

import 'signalr_socket_platform_interface.dart';

/// A web implementation of the SignalrSocketPlatform of the SignalrSocket plugin.
class SignalrSocketWeb extends SignalrSocketPlatform {
  /// Constructs a SignalrSocketWeb
  SignalrSocketWeb() {
    signalrSocketUpdateStatusWeb = allowInterop((status) {
      if (status is int) {
        if (status <= 6) {
          final connectionStatus = SignalrSocketConnectionStatus.values[status];

          SignalrSocketPlatform.instance.callBack
              .updateStatus(connectionStatus);
        }
      }
    });

    signalrSocketNewMessageWeb = allowInterop((newMessage) {
      SignalrSocketPlatform.instance.callBack.newMessage(newMessage);
    });
  }

  static void registerWith(Registrar registrar) {
    SignalrSocketPlatform.instance = SignalrSocketWeb();
  }

  @override
  connect({
    required String url,
    required String hubName,
    required String eventName,
    required Map<String, String> queryString,
  }) async {
    String queryStringString = "";

    queryString.forEach((key, value) {
      if (queryStringString.isEmpty) {
        queryStringString = "$key=$value";
      } else {
        queryStringString = "&$key=$value";
      }
    });

    connectSignalrSocketWeb(url, hubName, eventName, queryStringString);
  }

  @override
  disconnect() {
    disconnectSignalrSocketWeb();
  }

  @override
  Future<bool> isConnected() async {
    return false;
  }
}

@JS('connectSocket')
external connectSignalrSocketWeb(
    dynamic url, dynamic hubName, dynamic eventName, dynamic queryString);

@JS('disconnectSocket')
external disconnectSignalrSocketWeb();

@JS('connectionStatus')
external set signalrSocketUpdateStatusWeb(
    void Function(dynamic connectionStatus) f);

@JS('newMessage')
external set signalrSocketNewMessageWeb(void Function(dynamic newMessage) f);
