//
//  SignalR.swift
//
//  Created by Arash on 4/9/22.
//

import Foundation

class SignalR {
    static let instance = SignalR()
    
    var hubProxy: HubProxy?
    var hubConnection: HubConnection?
    
    func connect(url: String, hubName: String, eventName: String, queryString: [String: String], updateConnectionStatus: @escaping (Int) -> Void, newMessage: @escaping (Dictionary<String, Any>) -> Void) {
        hubConnection = HubConnection(withUrl: url)
        hubProxy = hubConnection!.createHubProxy(hubName: hubName)
        
        hubConnection!.queryString = queryString
        
        _ = hubProxy!.on(eventName: eventName) { args in
            if let dictionary = args[0] as? Dictionary<String, Any> {
                newMessage(dictionary)
            }
        }
        
        // MARK: - SignalR events
        hubConnection!.started = {
            updateConnectionStatus(ConnectionStatus.connected.rawValue)
        }

        hubConnection!.reconnecting = {
            updateConnectionStatus(ConnectionStatus.reconnecting.rawValue)
        }

        hubConnection!.reconnected = {
            updateConnectionStatus(ConnectionStatus.reconnected.rawValue)
        }

        hubConnection!.closed = {
            updateConnectionStatus(ConnectionStatus.disconnected.rawValue)
        }

        hubConnection!.connectionSlow = {
            updateConnectionStatus(ConnectionStatus.connectionSlow.rawValue)
        }

        hubConnection!.error = { error in
            print("Connection error", error)
            
            updateConnectionStatus(ConnectionStatus.connectingError.rawValue)
        }
        
        hubConnection!.start()
        
        updateConnectionStatus(ConnectionStatus.connecting.rawValue)
    }
    
    func disconnect() {
        hubConnection?.stop()
    }
    
    func isConnected() -> Bool {
        return hubConnection?.state == SignalRConnectionState.connected
    }
}

enum ConnectionStatus: Int {
    case connected = 0
    case connecting = 1
    case disconnected = 2
    case reconnected = 3
    case reconnecting = 4
    case connectionSlow = 5
    case connectingError = 6
}
