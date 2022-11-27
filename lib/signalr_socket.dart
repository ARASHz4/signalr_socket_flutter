import 'signalr_socket_platform_interface.dart';

class SignalrSocket {
  final String url;
  final String hubName;
  final String eventName;
  final Map<String, String> queryString;
  final Function(SignalrSocketConnectionStatus) updateConnectionStatus;
  final Function(dynamic) newMessage;

  SignalrSocket({
    required this.url,
    required this.hubName,
    required this.eventName,
    required this.queryString,
    required this.updateConnectionStatus,
    required this.newMessage,
  }) {
    SignalrSocketPlatform.instance.callBack.onUpdateStatus = updateConnectionStatus;
    SignalrSocketPlatform.instance.callBack.onNewMessage = newMessage;
  }

  connect() async {
    SignalrSocketPlatform.instance.connect(url: url, hubName: hubName, eventName: eventName, queryString: queryString);
  }

  disconnect() {
    SignalrSocketPlatform.instance.disconnect();
  }

  Future<bool> isConnected() async {
    return SignalrSocketPlatform.instance.isConnected();
  }

  Future<String?> getPlatformVersion() {
    return SignalrSocketPlatform.instance.getPlatformVersion();
  }
}

enum SignalrSocketConnectionStatus {
  connected(0),
  connecting(1),
  disconnected(2),
  reconnected(3),
  reconnecting(4),
  connectionSlow(5),
  connectingError(6);

  const SignalrSocketConnectionStatus(this.value);

  final int value;
}
