import Foundation
import LocalAuthentication
import SwiftUI

class AppLockManager: ObservableObject {
    @Published var isUnlocked = false
    @AppStorage("appLockEnabled") var appLockEnabled: Bool = true

    func unlock() {
        let context = LAContext()
        var error: NSError?

        // Check if biometric auth is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock NeuroNest with Face ID / Touch ID"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    self.isUnlocked = success
                }
            }
        } else {
            DispatchQueue.main.async {
                self.isUnlocked = true // fallback if not available
            }
        }
    }
}
