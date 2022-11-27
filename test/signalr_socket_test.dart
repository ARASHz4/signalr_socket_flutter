import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:signalr_socket/signalr_socket_method_channel.dart';
import 'package:signalr_socket/signalr_socket_platform_interface.dart';

class MockSignalrSocketPlatform with MockPlatformInterfaceMixin implements SignalrSocketPlatform {
  @override
  connect({
    required String url,
    required String hubName,
    required String eventName,
    required Map<String, String> queryString,
  }) {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Future<bool> isConnected() {
    // TODO: implement isConnected
    throw UnimplementedError();
  }

  @override
  late SignalrSocketCallBack callBack;
}

void main() {
  final SignalrSocketPlatform initialPlatform = SignalrSocketPlatform.instance;

  test('$MethodChannelSignalrSocket is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSignalrSocket>());
  });
}
