# signalr_socket

A flutter plugin for aspx.net SignalR client for Android, iOS, macOS and Web

## Getting Started

### Add dependency

```yaml
dependencies:
  signalr_socket: ^1.0.2 #latest version
```

Initialize SignalR Socket & connect to server.

```dart
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

signalrSocket.connect();
```
