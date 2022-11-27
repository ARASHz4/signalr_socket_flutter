import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signalr_socket/signalr_socket_method_channel.dart';

void main() {
  MethodChannelSignalrSocket platform = MethodChannelSignalrSocket();
  const MethodChannel channel = MethodChannel('signalr_socket');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  platform.connect(url: 'https://signalr.socket.com',
    hubName: 'hubName',
    eventName: 'eventName',
    queryString: {'key': 'value'},
  );
}
