import SwiftUI

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = WorkoutViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {

                    // HEADER
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Workouts")
                            .font(.largeTitle.bold())
                        Text("Strengthen your plan 💪")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    // MUSCLE GROUPS (FILTER SECTION)
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Muscle Groups")
                                .font(.title3.bold())
                            Spacer()
                            if viewModel.selectedMuscleGroupID != nil {
                                Button("Clear") {
                                    withAnimation { viewModel.selectedMuscleGroupID = nil }
                                }
                                .font(.caption.bold())
                            }
                        }
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(viewModel.uniqueMuscleGroups) { group in
                                    // Filtreleme butonu olarak çalışır
                                    Button {
                                        withAnimation {
                                            if viewModel.selectedMuscleGroupID == group.id {
                                                viewModel.selectedMuscleGroupID = nil
                                            } else {
                                                viewModel.selectedMuscleGroupID = group.id
                                            }
                                        }
                                    } label: {
                                        MuscleGroupChipView(
                                            group: group,
                                            isSelected: viewModel.selectedMuscleGroupID == group.id
                                        )
                                    }
                                    // Kategori detayına gitmek istersen ContextMenu ekleyebilirsin:
                                    .contextMenu {
                                        NavigationLink("Edit Category") {
                                            MuscleGroupDetailView(viewModel: viewModel, group: group, isNew: false)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // EXERCISES (FILTERED LIST)
                    VStack(alignment: .leading, spacing: 14) {
                        Text(viewModel.selectedMuscleGroupID == nil ? "All Exercises" : "Filtered Exercises")
                            .font(.title3.bold())
                            .padding(.horizontal)

                        LazyVStack(spacing: 14) {
                            ForEach(viewModel.filteredExercises) { ex in
                                NavigationLink {
                                    DetailView(viewModel: viewModel, exercise: ex, isNew: false)
                                } label: {
                                    ExerciseCardView(exercise: ex)
                                }
                                .buttonStyle(PlainButtonStyle()) // TÜM SATIRIN MAVİ OLMASINI ENGELLER
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical, 24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        NavigationLink("New Exercise") {
                            DetailView(viewModel: viewModel, exercise: Exercise(id: nil, name: "", description: "", isCardio: false, sets: 0, reps: 0, muscleGroupID: viewModel.muscleGroups.first?.id ?? 0), isNew: true)
                        }
                        NavigationLink("New Category") {
                            MuscleGroupDetailView(viewModel: viewModel, group: MuscleGroup(id: nil, groupName: "", yearEstablished: 2026), isNew: true)
                        }
                    } label: {
                        Image(systemName: "plus").font(.title2)
                    }
                }
            }
        }
        .onAppear {
            print("Veriler çekiliyor...") // Konsolda bunu görüyor musun bak!
            viewModel.fetchAllData()
        }
    }
}
#Preview {
    let mockVM = WorkoutViewModel()
    // Opsiyonel: Preview'da boş kalmasın diye manuel veri ekleyebilirsin
    mockVM.muscleGroups = [MuscleGroup(id: 1, groupName: "Chest", yearEstablished: 2024)]
    mockVM.exercises = [Exercise(id: 1, name: "Bench Press", description: "Standard", isCardio: false, sets: 3, reps: 12, muscleGroupID: 1)]
    
    return HomeView(viewModel: mockVM)
}
