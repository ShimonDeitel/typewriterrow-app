import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var purchases: PurchaseManager
    @Environment(\.dismiss) var dismiss
    @AppStorage("notifyEnabled") private var notifyEnabled = true
    @AppStorage("showNotesEnabled") private var showNotesEnabled = true

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Enable Alerts", isOn: $notifyEnabled)
                        .accessibilityIdentifier("toggleAlerts")
                    Toggle("Show Notes on List", isOn: $showNotesEnabled)
                        .accessibilityIdentifier("toggleNotes")
                }
                Section("Pro") {
                    if purchases.isPro {
                        Label("Pro Unlocked", systemImage: "checkmark.seal.fill")
                    } else {
                        Button("Restore Purchases") {
                            Task { await purchases.restore() }
                        }
                        .accessibilityIdentifier("restoreButton")
                    }
                }
                Section("Legal") {
                    Link("Privacy Policy", destination: URL(string: "https://example.com/privacy.html")!)
                    Link("Terms of Use", destination: URL(string: "https://example.com/terms.html")!)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                        .accessibilityIdentifier("settingsDoneButton")
                }
            }
        }
    }
}
