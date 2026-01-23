//
//  ContentView.swift
//  SSLPinningDemo
//
//  Created by Nikunj Damani on 22/01/26.
//

import SwiftUI
import FactoryKit

struct SSLPinningDemoStatusView: View {
    @StateObject private var sslPinningViewModel = Container.shared.sslPinningViewModel()
     
    var body: some View {
        VStack {
            Text("SSL pinning status: \(sslPinningViewModel.status)")
        }
        .task {
            try? await sslPinningViewModel.fetch()
        }
    }
}

#Preview {
    SSLPinningDemoStatusView()
}
