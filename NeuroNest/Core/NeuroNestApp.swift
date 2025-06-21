import SwiftUI

@main
struct NeuroNestApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var lockManager = AppLockManager()

    var body: some Scene {
        WindowGroup {
            Group {
                if lockManager.appLockEnabled && !lockManager.isUnlocked {
                    LockScreenView()
                        .environmentObject(lockManager)
                } else {
                    HomeView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
        }
    }
}
