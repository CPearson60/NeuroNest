import SwiftUI

struct MemoryNodeBubble: View {
    let memory: Memory
    var isRoot: Bool = false

    @State private var pulse = false

    private var emotionColor: Color {
        switch memory.emotion?.lowercased() {
        case "joy": return .yellow
        case "sadness": return .blue
        case "anger": return .red
        case "love": return .pink
        case "fear": return .gray
        case "surprise": return .orange
        case "peace": return .green
        default: return isRoot ? .purple : .cyan
        }
    }

    var body: some View {
        Text(memory.title?.prefix(1).uppercased() ?? "M")
            .font(.title3)
            .fontWeight(.bold)
            .frame(width: isRoot ? 70 : 50, height: isRoot ? 70 : 50)
            .background(emotionColor.opacity(0.9))
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(pulse ? 1.07 : 1.0)
            .shadow(color: emotionColor.opacity(pulse ? 0.7 : 0.4), radius: pulse ? 15 : 8)
            .overlay(
                Circle()
                    .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
            )
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                    pulse.toggle()
                }
            }
    }
}
