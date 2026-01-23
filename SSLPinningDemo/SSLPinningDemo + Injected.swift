//
//  SSLPinningDemo + Injected.swift
//  SSLPinningDemo
//
//  Created by Nikunj Damani on 22/01/26.
//

import FactoryKit
import Foundation

extension Container {
    var pinnedURLSession: Factory<URLSession> {
        Factory(self) { URLSession(configuration: .default,
                                   delegate: SSLPinningSessionDelegate(),
                                   delegateQueue: nil) }
    }
    
    var networkClient: Factory<NetworkClient> {
        Factory(self) { NetworkClient() }
    }
    
    var sslPinningViewModel: Factory<SSLPinningDemoViewModel> {
        Factory(self) {
            SSLPinningDemoViewModel()
        }
    }
}
