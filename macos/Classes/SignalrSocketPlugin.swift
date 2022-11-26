import Cocoa
import FlutterMacOS

public class SignalrSocketPlugin: NSObject, FlutterPlugin {
    
    static var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "signalr_socket", binaryMessenger: registrar.messenger)
        let instance = SignalrSocketPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
        case SignalRCallMethod.connect.rawValue:
            if let arguments = call.arguments as? Dictionary<String, Any>,
               let url = arguments["url"] as? String,
               let hubName = arguments["hubName"] as? String,
               let eventName = arguments["eventName"] as? String,
               let queryString = arguments["queryString"] as? [String : String] {
                SignalR.instance.connect(url: url, hubName: hubName, eventName: eventName, queryString: queryString, updateConnectionStatus: { connectionStatus in
                    SignalrSocketPlugin.channel?.invokeMethod("connectionStatus", arguments: connectionStatus)
                }) { message in
                    SignalrSocketPlugin.channel?.invokeMethod("newMessage", arguments: message)
                }
            }
            
            break
            
        case SignalRCallMethod.disconnect.rawValue:
            SignalR.instance.disconnect()
            break
            
        case SignalRCallMethod.isConnected.rawValue:
            result(SignalR.instance.isConnected())
            break
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

enum SignalRCallMethod : String {
    case connect, disconnect, isConnected
}
