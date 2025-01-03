//
//  SettingsView.swift
//  StikEMU
//
//  Created by Stephen on 10/11/24.
//
import SwiftUI

struct SettingsView: View {
    @Binding var keyBindings: [String: String]
    @Binding var showControls: Bool
    @Binding var useDirectionPad: Bool
    @Binding var thumbstickMapping: String
    @Binding var isPresented: Bool
    
    @State private var showResetConfirmation = false // Added state for alert
    
    let keyOptions = ["Space", "KeyA", "KeyB", "KeyX", "KeyY", "KeyW", "KeyS", "KeyD", "ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                // Header with Settings Title, Done Button, and Reset Button
                HStack {
                    Text("Settings")
                        .font(.title2)
                        .bold()
                    Spacer()
                    // Reset Button
                    Button(action: {
                        showResetConfirmation = true // Show confirmation alert
                    }) {
                        Text("Reset")
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                    .padding(.trailing, 10)
                    
                    // Done Button
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Done")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                .alert(isPresented: $showResetConfirmation) {
                    Alert(
                        title: Text("Reset Settings"),
                        message: Text("Are you sure you want to reset all settings to their default values?"),
                        primaryButton: .destructive(Text("Reset")) {
                            resetSettings()
                        },
                        secondaryButton: .cancel()
                    )
                }
                
                // Rest of the settings UI
                Toggle("Show UI Controls", isOn: $showControls)
                    .padding(.horizontal)
                
                Toggle("Use Direction Pad", isOn: $useDirectionPad)
                    .padding(.horizontal)
                
                Picker("Thumbstick Mapping", selection: $thumbstickMapping) {
                    Text("Arrow Keys").tag("Arrow Keys")
                    Text("WASD").tag("WASD")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                ForEach(["space", "buttonB", "buttonX", "buttonY"], id: \.self) { key in
                    HStack {
                        Text("\(key.capitalized):")
                        Spacer()
                        Picker(selection: binding(for: key), label: Text(keyBindings[key] ?? "")) {
                            ForEach(keyOptions, id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 150)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                // Credits Section
                HStack {
                    Text("Credits")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("App made by Stephen")
                        .font(.subheadline)
                    
                    Text("Flash code by Ruffle")
                        .font(.subheadline)
                }
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .background(Color(.systemGroupedBackground))
            .cornerRadius(12)
            .padding()
        }
        .preferredColorScheme(.dark) // This forces dark mode
    }
    
    private func resetSettings() {
        // Reset the settings to default values
        keyBindings = [
            "space": "Space",
            "buttonB": "KeyB",
            "buttonX": "KeyX",
            "buttonY": "KeyY"
        ]
        showControls = true
        useDirectionPad = false
        thumbstickMapping = "Arrow Keys"
    }
    
    private func binding(for key: String) -> Binding<String> {
        Binding<String>(
            get: { keyBindings[key] ?? "" },
            set: { newValue in keyBindings[key] = newValue }
        )
    }
}
