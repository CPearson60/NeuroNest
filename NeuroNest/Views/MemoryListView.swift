import SwiftUI
import CoreData

struct MemoryListView: View {
    @FetchRequest(
        entity: Memory.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Memory.date, ascending: false)]
    ) var memories: FetchedResults<Memory>

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        NavigationView {
            List {
                if memories.isEmpty {
                    Text("No memories yet.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(memories) { memory in
                        NavigationLink(destination: MemoryDetailView(memory: memory)) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(memory.title ?? "Untitled")
                                    .font(.headline)

                                HStack {
                                    Text(memory.emotion ?? "Unknown Emotion")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(memory.tag ?? "Untagged")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }

                                Text(dateFormatter.string(from: memory.date ?? Date()))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Your Memories")
        }
    }
}
