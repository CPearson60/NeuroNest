import SwiftUI

struct NeuralMapView: View {
    @FetchRequest(
        entity: Memory.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Memory.date, ascending: true)]
    ) var memories: FetchedResults<Memory>

    @State private var selectedMemory: Memory?

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                if let root = memories.first {
                    RadialMemoryNode(memory: root, allMemories: Array(memories)) { selected in
                        selectedMemory = selected
                    }
                } else {
                    Text("No memories yet.")
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            .navigationTitle("Neural Map")
            .sheet(item: $selectedMemory) { memory in
                MemoryDetailView(memory: memory)
            }
        }
    }
}
