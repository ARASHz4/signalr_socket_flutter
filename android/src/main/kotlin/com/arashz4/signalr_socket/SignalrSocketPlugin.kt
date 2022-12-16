package com.arashz4.signalr_socket

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SignalrSocketPlugin */
class SignalrSocketPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    companion object {
        private val signalR: SignalR = SignalR
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "signalr_socket")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            CallMethod.Connect.value -> {
                val arguments = call.arguments as Map<*, *>

                val url = arguments["url"] as String
                val hubName = arguments["hubName"] as String
                val eventName = arguments["eventName"] as String
                val queryStrings = arguments["queryString"] as Map<String, String>

                signalR.connect(
                    url,
                    hubName,
                    eventName,
                    queryStrings,
                    { status ->
                        channel.invokeMethod("connectionStatus", status)
                    },
                    { message ->
                        channel.invokeMethod("newMessage", message)
                    },
                    {
                        result.success(true)
                    },
                )
            }
            CallMethod.Disconnect.value -> {
                signalR.disconnect {
                    channel.invokeMethod("connectionStatus", ConnectionStatus.Disconnected.value)
                }
            }
            CallMethod.IsConnected.value -> {
                signalR.isConnected {
                    result.success(it)
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

enum class CallMethod(val value: String) {
    Connect("connect"),
    Disconnect("disconnect"),
    IsConnected("isConnected")
}
