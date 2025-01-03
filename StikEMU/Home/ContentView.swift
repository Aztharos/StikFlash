//
//  ContentView.swift
//  StikEMU
//
//  Created by Stephen on 10/12/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var selectedFile: URL? = nil
    @State private var isActive: Bool = true
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    EmptyView()
                    
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $isActive) {
                FlashEmulatorView(selectedFile: $selectedFile)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationSplitViewStyle(.balanced)
            .navigationBarHidden(true)
        }
    }
}
