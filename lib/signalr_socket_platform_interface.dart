import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:signalr_socket/signalr_socket.dart';
import 'signalr_socket_method_channel.dart';

abstract class SignalrSocketPlatform extends PlatformInterface {
  /// Constructs a SignalrSocketPlatform.
  SignalrSocketPlatform() : super(token: _token);

  static final Object _token = Object();

  static SignalrSocketPlatform _instance = MethodChannelSignalrSocket();

  SignalrSocketCallBack callBack = SignalrSocketCallBack();

  /// The default instance of [SignalrSocketPlatform] to use.
  ///
  /// Defaults to [MethodChannelSignalrSocket].
  static SignalrSocketPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SignalrSocketPlatform] when
  /// they register themselves.
  static set instance(SignalrSocketPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  connect(
      {required String url,
      required String hubName,
      required String eventName,
      required Map<String, String> queryString}) async {
    throw UnimplementedError(
        'signalr socket connect has not been implemented.');
  }

  disconnect() {
    throw UnimplementedError(
        'signalr socket disconnect has not been implemented.');
  }

  Future<bool> isConnected() async {
    throw UnimplementedError(
        'signalr socket isConnected has not been implemented.');
  }
}

class SignalrSocketCallBack {
  updateStatus(SignalrSocketConnectionStatus connectionStatus) {
    onUpdateStatus?.call(connectionStatus);
  }

  newMessage(dynamic message) {
    onNewMessage?.call(message);
  }

  void Function(SignalrSocketConnectionStatus connectionStatus)? onUpdateStatus;
  void Function(dynamic message)? onNewMessage;
}
