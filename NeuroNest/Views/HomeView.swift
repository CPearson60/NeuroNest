import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to NeuroNest 🧠")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()

                Text("Tap below to begin onboarding.")
                    .foregroundColor(.secondary)

                NavigationLink("Start Onboarding", destination: OnboardingView())
                    .padding()
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)

                NavigationLink("View Profile", destination: UserProfileView())
                    .padding()
                    .background(Color.green.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                
                NavigationLink("Add Memory", destination: MemoryEntryView())
                    .padding()
                    .background(Color.purple.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                NavigationLink("View All Memories", destination: MemoryListView())
                    .padding()
                    .background(Color.orange.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                NavigationLink("Neural Timeline", destination: NeuralTimelineView())
                    .padding()
                    .background(Color.indigo.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                NavigationLink("Neural Map", destination: NeuralMapView())
                    .padding()
                    .background(Color.black.opacity(0.9))
                    .foregroundColor(.white)
                    .cornerRadius(12)


            }
            .padding()
        }
    }
}
