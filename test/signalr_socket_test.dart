import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:signalr_socket/signalr_socket.dart';
import 'package:signalr_socket/signalr_socket_method_channel.dart';
import 'package:signalr_socket/signalr_socket_platform_interface.dart';

class MockSignalrSocketPlatform
    with MockPlatformInterfaceMixin
    implements SignalrSocketPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  SignalrSocketCallBack callBack;

  @override
  connect({required String url, required String hubName, required String eventName, required Map<String, String> queryString}) {
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
}

void main() {
  final SignalrSocketPlatform initialPlatform = SignalrSocketPlatform.instance;

  test('$MethodChannelSignalrSocket is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSignalrSocket>());
  });

  test('getPlatformVersion', () async {
    SignalrSocket signalrSocketPlugin = SignalrSocket(
      url: 'https://signalr.socket.com',
      hubName: 'hubName',
      eventName: "eventName",
      queryString: {'key': 'value'},
      updateStatus: (status) {
        print("signalr socket update connection status ${status.name}");
      },
      newMessage: (message) {
        print("signalr socket new message $message");
      },
    );

    MockSignalrSocketPlatform fakePlatform = MockSignalrSocketPlatform();
    SignalrSocketPlatform.instance = fakePlatform;

    expect(await signalrSocketPlugin.getPlatformVersion(), '42');
  });
}
