//
//  ExerciseCardView.swift
//  WorkoutTracker
//
//  Created by Emirhan Gökçe on 4.01.2026.
//

import SwiftUI

struct ExerciseCardView: View {
    let exercise: Exercise

    var body: some View {
        HStack{
            Image(systemName: exercise.isCardio ? "figure.run.treadmill" : "figure.strengthtraining.traditional")
                .font(.system(size: 32))
                .foregroundStyle(.black.opacity(0.8))
                .padding(16)
                .background(
                    Circle()
                        .fill(LinearGradient(colors: [.green.opacity(0.8),.green.opacity(0.3)], startPoint: .top, endPoint: .bottom))
                )
                .shadow(radius: 10)
            
            VStack(alignment: .leading, spacing: 12) {

                HStack {
                    Text(exercise.name)
                        .foregroundStyle(.black)
                        .font(.headline)
                        .bold()

                    Spacer()

                    if exercise.isCardio {
                        Label("Cardio", systemImage: "heart.fill")
                            .font(.caption.bold())
                            .foregroundStyle(.red)
                    }
                }

                Text(exercise.description)
                    .foregroundStyle(.secondary)
                    .font(.caption)
                    .fontWeight(.semibold)

                HStack(spacing: 16) {
                    Label("\(exercise.sets) Set", systemImage: "square.stack.3d.up")
                    Label("\(exercise.reps) Tekrar", systemImage: "repeat")
                }
                .font(.caption.bold())
                .foregroundStyle(LinearGradient(colors: [.purple, .pink], startPoint: .top, endPoint: .bottom))
            }

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.thinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.15))
        )
    }
}


#Preview {
    ExerciseCardView(exercise: Exercise(name: "Bench Press", description: "Gogusler icin harika", isCardio: true, sets: 4, reps: 12, muscleGroupID: 1))
}
