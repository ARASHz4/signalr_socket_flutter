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
    // signalrSocket = SignalrSocket(
    //   url: 'https://signalr.socket.com',
    //   hubName: 'hubName',
    //   eventName: 'eventName',
    //   queryString: {'key': 'value'},
    //   updateConnectionStatus: (connectionStatus) {
    //     debugPrint("signalr socket update connection status ${connectionStatus.name}");
    //
    //     setState(() {
    //       this.connectionStatus = connectionStatus;
    //     });
    //   },
    //   newMessage: (message) {
    //     debugPrint("signalr socket new message $message");
    //
    //     setState(() {
    //       if (output.isEmpty) {
    //         output = message;
    //       }
    //       else {
    //         output += "\n $message";
    //       }
    //     });
    //   },
    // );

    signalrSocket = SignalrSocket(
      url: "https://avl.opp.co.ir:8099/socket",
      hubName: "avlHub",
      eventName: "newPlace",
      queryString: {"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJmN2EzZjMwMS03NGFlLTViNzQtZDI2Yy1kNWUwMGM0OGI2YzAiLCJpc3MiOiJodHRwOi8vb3BwLmNvLmlyLyIsImlhdCI6MTY2OTAzMDE0OSwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiIwYmJmZGNkMi00ODExLTRiNWEtOWNiNS1iMDFmNWY1OGMzZjUiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoibmlndGM0IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbW9iaWxlcGhvbmUiOiIwOTAxMzEwODQ4NCIsImNvbXBhbnlJZCI6IjA0ZTIwMWEzLTNmY2ItNDNhZi1iYTAwLTU5ZTQzYzEzMGE4YiIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkdQU0FkbWluIiwibmJmIjoxNjY5MDMwMTQ5LCJleHAiOjE3MDA1NjYxNDksImF1ZCI6IkFueSJ9.ldMkOd3yBsSvRhT3es3vnF6ri9EmN4GYXhz-sJCQlEo"},
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
