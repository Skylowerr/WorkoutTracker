
import SwiftUI

struct MuscleGroupChipView: View {
    let group: MuscleGroup
    let isSelected: Bool

    var body: some View {
        Text(group.groupName)
            .font(.subheadline.bold())
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .foregroundStyle(isSelected ? .white : .primary)
            .background(
                Capsule()
                    .fill(isSelected ? Color.blue : Color(.tertiarySystemBackground))
            )
            .overlay(
                Capsule()
                    .stroke(Color.blue.opacity(isSelected ? 0 : 0.2), lineWidth: 1)
            )
    }
}

#Preview {
    ZStack {
        // Arka plana bir renk koyalım ki ultraThinMaterial belli olsun
        Color.blue.ignoresSafeArea()
        
        MuscleGroupChipView(group: MuscleGroup(
            id: 1,
            groupName: "Chest",
            yearEstablished: 2024
        ), isSelected: true)
    }
}
