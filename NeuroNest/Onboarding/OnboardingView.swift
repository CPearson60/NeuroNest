import SwiftUI

struct OnboardingView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var name: String = ""
    @State private var age: String = ""
    @State private var profession: String = ""
    @State private var showError = false
    @State private var navigateHome = false

    var body: some View {
        VStack(spacing: 24) {
            Text("🧠 Welcome to NeuroNest")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)

            VStack(alignment: .leading, spacing: 16) {
                TextField("Your Name", text: $name)
                    .textFieldStyle(.roundedBorder)

                TextField("Your Age", text: $age)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)

                TextField("Profession (optional)", text: $profession)
                    .textFieldStyle(.roundedBorder)
            }

            Button(action: saveProfile) {
                Text("Continue")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            if showError {
                Text("Please enter your name and age.")
                    .foregroundColor(.red)
                    .font(.caption)
            }

            NavigationLink(destination: HomeView(), isActive: $navigateHome) {
                EmptyView()
            }
        }
        .padding()
    }

    private func saveProfile() {
        guard !name.isEmpty, let ageInt = Int16(age) else {
            showError = true
            return
        }

        let profile = UserProfile(context: viewContext)
        profile.name = name
        profile.age = ageInt
        profile.profession = profession

        do {
            try viewContext.save()
            navigateHome = true
        } catch {
            print("❌ Failed to save profile: \(error.localizedDescription)")
        }
    }
}
