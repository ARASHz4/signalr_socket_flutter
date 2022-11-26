package com.arashz4.signalr_socket

import android.os.Handler
import android.os.Looper
import com.github.signalr4j.client.ConnectionState
import com.github.signalr4j.client.LogLevel
import com.github.signalr4j.client.hubs.HubConnection

object SignalR {
    private lateinit var connection: HubConnection

    fun connect(url: String, hubName: String, eventName: String, queryStrings: Map<String, String>, updateStatus: (Int) -> Unit, newMessage: (Any) -> Unit, connected: () -> Unit) {
        try {
            var queryString = ""
            for (query in queryStrings) {
                if (queryString.isEmpty()) {
                    queryString = query.key + "=" + query.value
                }
                else {
                    queryString += "?" + query.key + "=" + query.value
                }
            }

            connection = HubConnection(url, queryString, false) { _: String, _: LogLevel -> }
            val hub = connection.createHubProxy(hubName)

            hub.on(eventName, { response ->
                Handler(Looper.getMainLooper()).post {
                    newMessage(response)
                }
            }, Any::class.java)

            var isFirst = true

            connection.connected {
                Handler(Looper.getMainLooper()).post {
                    if (isFirst) {
                        isFirst = false
                        connected()
                    }
                    updateStatus(ConnectionStatus.Connected.value)
                }
            }

            connection.reconnected {
                Handler(Looper.getMainLooper()).post {
                    updateStatus(ConnectionStatus.Reconnected.value)
                }
            }

            connection.reconnecting {
                Handler(Looper.getMainLooper()).post {
                    updateStatus(ConnectionStatus.Reconnecting.value)
                }
            }

            connection.closed {
                Handler(Looper.getMainLooper()).post {
                    updateStatus(ConnectionStatus.Disconnected.value)
                }
            }

            connection.connectionSlow {
                Handler(Looper.getMainLooper()).post {
                    updateStatus(ConnectionStatus.ConnectionSlow.value)
                }
            }

            connection.error {
                Handler(Looper.getMainLooper()).post {
                    updateStatus(ConnectionStatus.Error.value)
                }
            }

            connection.start()
        } catch (ex: Exception) {
            println("Error " + ex.localizedMessage)
        }
    }

    fun disconnect(disconnected: () -> Unit) {
        try {
            if (this::connection.isInitialized) {
                connection.stop()
                disconnected()
            }
        } catch (ex: Exception) {
            println(ex.localizedMessage?.plus(ex.stackTrace.toString()))
        }
    }

    fun isConnected(state: (Boolean) -> Unit) {
        try {
            if (this::connection.isInitialized) {
                state(connection.state == ConnectionState.Connected)
            } else {
                state(false)
            }
        } catch (ex: Exception) {
            println("Error " + ex.localizedMessage)
        }
    }
}

enum class ConnectionStatus(val value: Int) {
    Connected(0),
    Disconnected(1),
    Reconnected(2),
    Reconnecting(3),
    ConnectionSlow(4),
    Error(5)
}