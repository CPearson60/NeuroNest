import SwiftUI

struct MemoryEditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var memory: Memory

    @State private var title: String = ""
    @State private var emotion: String = ""
    @State private var notes: String = ""
    @State private var date: Date = Date()
    @State private var tag: String = ""

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
            }
            .navigationTitle("Edit Memory")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveChanges()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                loadFields()
            }
        }
    }

    private func loadFields() {
        title = memory.title ?? ""
        emotion = memory.emotion ?? ""
        notes = memory.notes ?? ""
        date = memory.date ?? Date()
        tag = memory.tag ?? ""
    }

    private func saveChanges() {
        memory.title = title
        memory.emotion = emotion
        memory.notes = notes
        memory.date = date
        memory.tag = tag

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("❌ Failed to update memory: \(error.localizedDescription)")
        }
    }
}
