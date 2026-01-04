import SwiftUI

struct MuscleGroupDetailView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @Environment(\.dismiss) var dismiss
    @State var group: MuscleGroup
    var isNew: Bool

    var body: some View {
        VStack(spacing: 24) {
            TextField("Category Name", text: $group.groupName)
                .textFieldStyle(.roundedBorder)

            TextField("Year Established", value: $group.yearEstablished, format: .number.grouping(.never))
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)

            Button {
                viewModel.performSaveMuscleGroup(group: group, isNew: isNew)
                dismiss()
            } label: {
                Text(isNew ? "Add Category" : "Save Changes")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)

            if !isNew {
                Button(role: .destructive) {
                    if let id = group.id {
                        viewModel.performDeleteMuscleGroup(id: id)
                        dismiss()
                    }
                } label: {
                    Text("Delete Category")
                        .frame(maxWidth: .infinity)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle(isNew ? "New Category" : "Category Details")
    }
}

#Preview {
    NavigationStack {
        MuscleGroupDetailView(
            viewModel: WorkoutViewModel(),
            group: MuscleGroup(id: 1, groupName: "Back", yearEstablished: 2020),
            isNew: false
        )
    }
}
