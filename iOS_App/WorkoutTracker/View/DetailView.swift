import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @Environment(\.dismiss) var dismiss
    @State var exercise: Exercise
    var isNew: Bool

    var body: some View {
        Form {
            Section("Details") {
                TextField("Name", text: $exercise.name)
                TextField("Description", text: $exercise.description)
                Toggle("Is Cardio?", isOn: $exercise.isCardio)
            }
            
            Section("Settings") {
                Stepper("Sets: \(exercise.sets)", value: $exercise.sets)
                Stepper("Reps: \(exercise.reps)", value: $exercise.reps)
                
                Picker("Category", selection: $exercise.muscleGroupID) {
                    ForEach(viewModel.uniqueMuscleGroups) { mg in
                        Text(mg.groupName).tag(mg.id ?? 0)
                    }
                }
            }
            
            Section {
                Button(action: {
                    // Create işlemi için kategori kontrolü
                    if isNew && exercise.muscleGroupID == 0 {
                        exercise.muscleGroupID = viewModel.muscleGroups.first?.id ?? 1
                    }
                    
                    // Binding hatasını önlemek için 'item:' parametresini kullanıyoruz
                    viewModel.performSaveExercise(item: self.exercise, isNew: isNew)
                    dismiss()
                }) {
                    Text(isNew ? "Create Exercise" : "Save Changes")
                        .frame(maxWidth: .infinity)
                        .bold()
                }
                .buttonStyle(.borderedProminent)
                .disabled(exercise.name.isEmpty)
                
                if !isNew {
                    Button(role: .destructive) {
                        if let id = exercise.id {
                            viewModel.performDeleteExercise(id: id)
                            dismiss()
                        }
                    } label: {
                        Text("Delete Exercise").frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .navigationTitle(isNew ? "New Entry" : "Edit")
    }
}

#Preview {
    DetailView(
        viewModel: WorkoutViewModel(),
        exercise: Exercise(id: 1, name: "Squat", description: "Leg day", isCardio: false, sets: 4, reps: 8, muscleGroupID: 1),
        isNew: false
    )
}
