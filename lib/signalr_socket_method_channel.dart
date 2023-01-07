import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:signalr_socket/signalr_socket.dart';

import 'signalr_socket_platform_interface.dart';

/// An implementation of [SignalrSocketPlatform] that uses method channels.
class MethodChannelSignalrSocket extends SignalrSocketPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('signalr_socket');

  @override
  connect({
    required String url,
    required String hubName,
    required String eventName,
    required Map<String, String> queryString,
  }) async {
    if (Platform.isAndroid || Platform.isIOS) {
      methodChannel.invokeMethod<bool>('connect', {
        'url': url,
        'hubName': hubName,
        'eventName': eventName,
        'queryString': queryString,
      });
    }
    else {
      final jquery = await rootBundle.loadString('packages/signalr_socket/js/jquery.min.js');
      final signalR = await rootBundle.loadString('packages/signalr_socket/js/jquery.signalR-2.4.3.min.js');
      final socketConnection = await rootBundle.loadString('packages/signalr_socket/js/socketConnection.js');

      javascriptRuntime.evaluate(jquery);
      javascriptRuntime.evaluate(signalR);
      javascriptRuntime.evaluate(socketConnection);

      javascriptRuntime.evaluate('connectSocket()');

      print(evalJS());
    }


    _signalRCallbackHandler();
  }

  final JavascriptRuntime javascriptRuntime = getJavascriptRuntime();

  String evalJS() {
    String jsResult = javascriptRuntime.evaluate("Math.trunc(Math.random() * 100).toString();").stringResult;
    return jsResult;
  }

  @override
  disconnect() {
    methodChannel.invokeMethod('disconnect');
  }

  @override
  Future<bool> isConnected() async {
    return await methodChannel.invokeMethod<bool>('isConnected') ?? false;
  }

  void _signalRCallbackHandler() {
    methodChannel.setMethodCallHandler((call) {
      switch (call.method) {
        case 'connectionStatus':
          if (call.arguments is int) {
            if (call.arguments <= 6) {
              final connectionStatus =
                  SignalrSocketConnectionStatus.values[call.arguments];

              SignalrSocketPlatform.instance.callBack
                  .updateStatus(connectionStatus);
            }
          }

          break;
        case 'newMessage':
          SignalrSocketPlatform.instance.callBack.newMessage(call.arguments);

          break;
        default:
      }
      return Future.value();
    });
  }
}
