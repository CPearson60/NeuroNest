import SwiftUI
import PhotosUI

struct MemoryEntryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var emotion: String = ""
    @State private var notes: String = ""
    @State private var date: Date = Date()
    @State private var tag: String = ""
    @State private var selectedImage: PhotosPickerItem?
    @State private var imageData: Data?

    @State private var showError: Bool = false

    let emotions = ["Joy", "Sadness", "Love", "Fear", "Anger", "Surprise", "Peace"]
    let tags = ["Family", "Friendship", "School", "Growth", "Faith", "Music", "Other"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Memory Info")) {
                    TextField("Title", text: $title)

                    Picker("Emotion", selection: $emotion) {
                        ForEach(emotions, id: \.self) { emotion in
                            Text(emotion)
                        }
                    }

                    DatePicker("Date", selection: $date, displayedComponents: .date)

                    Picker("Tag", selection: $tag) {
                        ForEach(tags, id: \.self) { tag in
                            Text(tag)
                        }
                    }
                }

                Section(header: Text("Details")) {
                    TextEditor(text: $notes)
                        .frame(height: 120)
                }

                Section(header: Text("Photo (optional)")) {
                    PhotosPicker("Choose Image", selection: $selectedImage, matching: .images)
                    if let imageData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(10)
                    }
                }

                if showError {
                    Text("Please enter at least a title and emotion.")
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button("Save Memory") {
                    saveMemory()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            }
            .onChange(of: selectedImage) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        imageData = data
                    }
                }
            }
            .navigationTitle("New Memory")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveMemory() {
        guard !title.isEmpty, !emotion.isEmpty else {
            showError = true
            return
        }

        let newMemory = Memory(context: viewContext)
        newMemory.title = title
        newMemory.emotion = emotion
        newMemory.notes = notes
        newMemory.date = date
        newMemory.tag = tag

        if let data = imageData {
            newMemory.imageData = data
        }

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("❌ Failed to save memory: \(error.localizedDescription)")
        }
    }
}
