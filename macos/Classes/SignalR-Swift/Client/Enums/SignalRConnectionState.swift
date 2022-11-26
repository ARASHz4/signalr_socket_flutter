//
//  ConnectionState.swift
//  SignalR-Swift
//
//  
//  Copyright © 2017 Jordan Camara. All rights reserved.
//

import Foundation

public enum SignalRConnectionState : Int {
    case connecting
    case connected
    case reconnecting
    case disconnected
}
