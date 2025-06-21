import SwiftUI
import LocalAuthentication

struct LockScreenView: View {
    @State private var isUnlocked = false
    @State private var showError = false

    var body: some View {
        Group {
            if isUnlocked {
                HomeView() // Or whatever your main view is
            } else {
                VStack(spacing: 20) {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 50))
                    Text("NeuroNest is locked")
                        .font(.title2)
                    Text("Unlock with Face ID / Touch ID")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Button("Unlock") {
                        authenticate()
                    }
                }
            }
        }
        .onAppear(perform: authenticate)
        .alert("Authentication Failed", isPresented: $showError) {
            Button("Retry", action: authenticate)
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock NeuroNest") { success, _ in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        showError = true
                    }
                }
            }
        } else {
            // fallback if Face ID/Touch ID not available
            showError = true
        }
    }
}
