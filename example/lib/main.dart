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
  SignalrSocketConnectionStatus connectionStatus = SignalrSocketConnectionStatus.disconnected;

  late SignalrSocket signalrSocket;

  List<String> outputs = [];

  ScrollController outputScrollController = ScrollController();

  @override
  void initState() {
    signalrSocket = SignalrSocket(
      url: "http://localhost:8080/signalr",
      hubName: "SignalrSocketHub",
      eventName: "SignalrSocketEvent",
      queryString: {'key': 'value'},
      updateConnectionStatus: (connectionStatus) {
        debugPrint("signalr socket update connection status ${connectionStatus.name}");

        setState(() {
          this.connectionStatus = connectionStatus;
        });
      },
      newMessage: newMessage,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SignalR Socket Example'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(connectionStatus.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  signalrSocket.connect();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Connect"),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  signalrSocket.disconnect();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Disconnect"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text("Output:"),
            ),
            Expanded(
              child: Scrollbar(
                controller: outputScrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: outputScrollController,
                  itemCount: outputs.length,
                  itemBuilder: (context, index) {
                    final output = outputs[index];

                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(output),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      outputScrollController.animateTo(
                        outputScrollController.position.minScrollExtent,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_circle_up),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        outputs = [];
                      });
                    },
                    icon: const Icon(Icons.clear_all),
                  ),
                  IconButton(
                    onPressed: () {
                      outputScrollController.animateTo(
                        outputScrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_circle_down),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  newMessage(dynamic message) {
    setState(() {
      outputs.add(message.toString());
    });
  }
}
