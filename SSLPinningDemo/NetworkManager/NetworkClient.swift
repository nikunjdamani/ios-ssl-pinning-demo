//
//  NetworkClient.swift
//  SSLPinningDemo
//
//  Created by Nikunj Damani on 22/01/26.
//

import Foundation
import FactoryKit

final class NetworkClient {
    @Injected(\.pinnedURLSession) private var urlSession
    
    init() {}
    
    func fetch(from url: String) async throws -> String {
        guard let stringURL = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await urlSession.data(from: stringURL)
            return String(decoding: data, as: UTF8.self)
        } catch let error{
            throw error
        }
    }
}
