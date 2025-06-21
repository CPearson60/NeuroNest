import SwiftUI

struct MemoryNodeView: View {
    let memory: Memory

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(memory.title ?? "Untitled")
                .font(.headline)
                .foregroundColor(.white)

            HStack {
                Text(memory.emotion ?? "Unknown")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))

                Spacer()

                Text(memory.tag ?? "—")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }

            Text(dateFormatter.string(from: memory.date ?? Date()))
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.purple.opacity(0.9))
                .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 6)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}
