import SwiftUI

struct NeuralTimelineView: View {
    @FetchRequest(
        entity: Memory.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Memory.date, ascending: true)]
    ) var memories: FetchedResults<Memory>

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(memories) { memory in
                        NavigationLink(destination: MemoryDetailView(memory: memory)) {
                            MemoryNodeView(memory: memory)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Neural Timeline")
        }
    }
}
