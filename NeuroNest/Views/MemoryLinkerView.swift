import SwiftUI

struct MemoryLinkerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @FetchRequest(
        entity: Memory.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Memory.date, ascending: true)]
    ) var allMemories: FetchedResults<Memory>

    let currentMemory: Memory
    @State private var selectedLinks: Set<Memory> = []

    var body: some View {
        NavigationView {
            List {
                ForEach(allMemories.filter { $0 != currentMemory }) { memory in
                    HStack {
                        Text(memory.title ?? "Untitled")
                        Spacer()
                        if selectedLinks.contains(memory) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        toggleLink(memory)
                    }
                }
            }
            .navigationTitle("Link Memories")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveLinks()
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                selectedLinks = Set(currentMemory.linkedMemories?.allObjects as? [Memory] ?? [])
            }
        }
    }

    private func toggleLink(_ memory: Memory) {
        if selectedLinks.contains(memory) {
            selectedLinks.remove(memory)
        } else {
            selectedLinks.insert(memory)
        }
    }

    private func saveLinks() {
        currentMemory.linkedMemories = NSSet(set: selectedLinks)
        do {
            try viewContext.save()
        } catch {
            print("❌ Failed to link memories: \(error)")
        }
    }
}
