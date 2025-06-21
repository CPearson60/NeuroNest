import SwiftUI

struct RadialMemoryNode: View {
    let memory: Memory
    let allMemories: [Memory]
    let onSelect: (Memory) -> Void

    var linkedMemories: [Memory] {
        (memory.linkedMemories?.allObjects as? [Memory]) ?? []
    }

    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius: CGFloat = min(geometry.size.width, geometry.size.height) / 3

            ZStack {
                ForEach(Array(linkedMemories.enumerated()), id: \.1) { index, linked in
                    let angle = Angle.degrees(Double(index) / Double(linkedMemories.count) * 360)
                    let x = center.x + cos(angle.radians) * radius
                    let y = center.y + sin(angle.radians) * radius

                    MemoryNodeBubble(memory: linked)
                        .position(x: x, y: y)
                        .onTapGesture {
                            onSelect(linked)
                        }
                }

                MemoryNodeBubble(memory: memory, isRoot: true)
                    .position(center)
                    .onTapGesture {
                        onSelect(memory)
                    }
            }
        }
    }
}
