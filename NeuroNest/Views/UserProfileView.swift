import SwiftUI
import CoreData

struct UserProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: UserProfile.entity(),
        sortDescriptors: []
    ) var profiles: FetchedResults<UserProfile>

    @State private var name: String = ""
    @State private var age: String = ""
    @State private var profession: String = ""
    @State private var isEditing: Bool = false
    @State private var showSaveAlert = false

    var body: some View {
        VStack(spacing: 20) {
            if let profile = profiles.first {
                Text("👤 Your Profile")
                    .font(.largeTitle)
                    .bold()

                if isEditing {
                    TextField("Name", text: $name)
                        .textFieldStyle(.roundedBorder)

                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)

                    TextField("Profession", text: $profession)
                        .textFieldStyle(.roundedBorder)

                    Button("Save Changes") {
                        saveChanges(for: profile)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("Cancel") {
                        isEditing = false
                        populateFields(with: profile)
                    }
                    .foregroundColor(.red)

                } else {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("**Name:** \(profile.name ?? "—")")
                        Text("**Age:** \(profile.age)")
                        Text("**Profession:** \(profile.profession ?? "Not provided")")
                    }
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Button("Edit Profile") {
                        isEditing = true
                        populateFields(with: profile)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

            } else {
                Text("No profile found.")
                    .foregroundColor(.gray)
                NavigationLink("Go to Onboarding", destination: OnboardingView())
                    .foregroundColor(.blue)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
        .alert(isPresented: $showSaveAlert) {
            Alert(title: Text("✅ Profile Updated"))
        }
    }

    private func populateFields(with profile: UserProfile) {
        name = profile.name ?? ""
        age = String(profile.age)
        profession = profile.profession ?? ""
    }

    private func saveChanges(for profile: UserProfile) {
        guard !name.isEmpty, let ageInt = Int16(age) else { return }

        profile.name = name
        profile.age = ageInt
        profile.profession = profession

        do {
            try viewContext.save()
            isEditing = false
            showSaveAlert = true
        } catch {
            print("❌ Failed to save changes: \(error)")
        }
    }
}
