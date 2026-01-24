//
//  SSLPinningDemoViewModel.swift
//  SSLPinningDemo
//
//  Created by Nikunj Damani on 22/01/26.
//

import Foundation
import FactoryKit

enum SSLPinningDemoStatus {
    case idle
    case fetching
    case verified
    case failed
}

class SSLPinningDemoViewModel: ObservableObject {
    @Injected(\.networkClient) private var networkClient
    
    @Published var status = SSLPinningDemoStatus.idle
    
    @MainActor
    func fetch() async {
        do {
            let _ = try await networkClient.fetch(from: "https://badssl.com")
            status = .verified
        } catch {
            status = .failed
        }
    }
}
