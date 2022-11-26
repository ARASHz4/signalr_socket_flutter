# signalr_socket

A flutter plugin for aspx.net SignalR client for Android, iOS, macOS and Web

## Getting Started

Note: This library is NOT compatible with ASP.NET Core SignalR

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

### Android Setup
- Add proguard rules for release mode in android
- Create a new file in your android project: android/app/proguard-rules.pro
- Add the following lines to the proguard-rules.pro
```
-keep class com.github.signalr4j.client.hubs.HubResult { *; }
-keep class com.github.signalr4j.client.hubs.HubInvocation { *; }
-keep class com.github.signalr4j.client.hubs.HubProxy$* { *; }
-keep class com.github.signalr4j.client.hubs.HubConnection {*;}
```

If you want a HTTP url, then you need to add the following lines to the manifest of your android project.

```xml
<application
        android:usesCleartextTraffic="true">
</application>
```

### Web Setup
- Add some js files to your web project in 'web/signalR_js'
- Download javascript files here https://github.com/ARASHz4/flutter_signalR_js/archive/refs/tags/1.0.0.zip
- Add 3 files 'jquery.min.js', 'signalr.js' and 'socketConnection.js' in 'web/signalR_js' folder
- Go to 'web/index.html' and add the following lines in header
```html
<head>
    <!--other lines-->

    <script defer type="application/javascript" src="signalR_js/jquery.min.js"></script>
    <script defer type="application/javascript" src="signalR_js/signalr.js"></script>
</head>
```
- And add the following line in body
```html
<body>
    <!--other lines-->

    <script defer type="application/javascript" src="signalR_js/socketConnection.js"></script>
</body>
```