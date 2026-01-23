//
//  SSLPinningDemoViewModel.swift
//  SSLPinningDemo
//
//  Created by Nikunj Damani on 22/01/26.
//

import Foundation
import FactoryKit

enum SSLPinningDemoStatus {
    case fetching
    case verified
    case failed
}

class SSLPinningDemoViewModel: ObservableObject {
    @Injected(\.networkClient) private var networkClient
    
    @Published var status = SSLPinningDemoStatus.fetching
    
    @MainActor
    func fetch() async throws {
        do {
            let _ = try await networkClient.fetch(from: "https://badssl.com")
            status = .verified
        } catch {
            print(error)
            status = .failed
        }
    }
}
