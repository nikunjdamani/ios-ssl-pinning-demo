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
            Text("SSL Pinning Demo")
                .font(.title)
            if sslPinningViewModel.status != SSLPinningDemoStatus.verified {
                Button ("Verify connection") {
                    Task {
                        await sslPinningViewModel.fetch()
                    }
                }
                .padding(10)
                .background(Color.blue)
                .cornerRadius(5)
                .foregroundColor(.white)
            } else {
                Text("SSL Connection verified")
                    .font(.headline)
            }
        }
        .alert("SSL verification failed", isPresented: Binding(get: { sslPinningViewModel.status == .failed
        }, set: { _ in sslPinningViewModel.status = .idle })) {
            Button("Ok") {}
        }
    }
}

#Preview {
    SSLPinningDemoStatusView()
}
