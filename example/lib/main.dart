import 'package:flutter/material.dart';
import 'package:signalr_socket/signalr_socket.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SignalrSocket signalrSocket = SignalrSocket(
    url: 'https://signalr.socket.com',
    hubName: 'hubName',
    eventName: 'eventName',
    queryString: {'key': 'value'},
    updateStatus: (status) {
      debugPrint("signalr socket update connection status ${status.name}");
    },
    newMessage: (message) {
      debugPrint("signalr socket new message $message");
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SignalR Socket Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  signalrSocket.connect();
                },
                child: const Text("Connect"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  signalrSocket.disconnect();
                },
                child: const Text("Disconnect"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
