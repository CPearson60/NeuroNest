import SwiftUI

struct MemoryDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var showingLinker = false


    let memory: Memory

    @State private var showingEdit = false
    @State private var showingDeleteAlert = false

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(memory.title ?? "Untitled")
                    .font(.largeTitle)
                    .bold()

                HStack {
                    Text(memory.emotion ?? "No emotion")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(memory.tag ?? "No tag")
                        .foregroundColor(.blue)
                }

                Text("Date: \(dateFormatter.string(from: memory.date ?? Date()))")
                    .font(.caption)
                    .foregroundColor(.gray)

                Divider()

                Text(memory.notes ?? "No notes provided.")
                    .font(.body)
                    .padding(.top, 10)
                
                if let data = memory.imageData,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                }


                Spacer()

                Button("Edit Memory") {
                    showingEdit = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Link Memories") {
                    showingLinker = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.cyan)
                .foregroundColor(.white)
                .cornerRadius(10)


                Button("Delete Memory") {
                    showingDeleteAlert = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Memory Detail")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingEdit) {
            MemoryEditView(memory: memory)
        }
        .alert("Delete Memory?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                deleteMemory()
            }
            Button("Cancel", role: .cancel) {}
        }.sheet(isPresented: $showingLinker) {
            MemoryLinkerView(currentMemory: memory)
        }

    }

    private func deleteMemory() {
        viewContext.delete(memory)
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("❌ Failed to delete memory: \(error.localizedDescription)")
        }
    }
}
