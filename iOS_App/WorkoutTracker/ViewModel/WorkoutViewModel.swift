import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var muscleGroups: [MuscleGroup] = []
    @Published var selectedMuscleGroupID: Int? = nil

    let baseExURL = "http://127.0.0.1:5099/api/exercises"
    let baseMgURL = "http://127.0.0.1:5099/api/musclegroups"

    
    // WorkoutViewModel.swift içinde
    var uniqueMuscleGroups: [MuscleGroup] {
        var seenNames = Set<String>()
        return muscleGroups.filter { group in
            if seenNames.contains(group.groupName.lowercased()) {
                return false
            } else {
                seenNames.insert(group.groupName.lowercased())
                return true
            }
        }
    }
    
    // Filtreleme mantığı
    var filteredExercises: [Exercise] {
        if let groupID = selectedMuscleGroupID {
            return exercises.filter { $0.muscleGroupID == groupID }
        }
        return exercises
    }

    func fetchAllData() {
        fetchMuscleGroups()
        fetchExercises()
    }

    // --- EXERCISE İŞLEMLERİ ---

    func fetchExercises() {
        guard let url = URL(string: baseExURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error { print("Exercise Fetch Error: \(error)"); return }
            if let data = data {
                if let decoded = try? JSONDecoder().decode([Exercise].self, from: data) {
                    DispatchQueue.main.async { withAnimation { self.exercises = decoded } }
                }
            }
        }.resume()
    }

    func performSaveExercise(item: Exercise, isNew: Bool) {
        let urlString = isNew ? baseExURL : "\(baseExURL)/\(item.id ?? 0)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = isNew ? "POST" : "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var uploadItem = item
        if isNew { uploadItem.id = 0 } // Backend için 0 veya nil

        do {
            request.httpBody = try JSONEncoder().encode(uploadItem)
        } catch { return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error { print("Save Exercise Error: \(error)"); return }
            DispatchQueue.main.async {
                self.fetchExercises()
            }
        }.resume()
    }

    func performDeleteExercise(id: Int) {
        guard let url = URL(string: "\(baseExURL)/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error { print("Delete Exercise Error: \(error)"); return }
            DispatchQueue.main.async {
                self.fetchExercises()
            }
        }.resume()
    }

    // --- MUSCLE GROUP İŞLEMLERİ ---

    func fetchMuscleGroups() {
        guard let url = URL(string: baseMgURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([MuscleGroup].self, from: data)
                    DispatchQueue.main.async { self.muscleGroups = decoded }
                } catch {
                    // EĞER BURASI ÇALIŞIRSA: C# tarafındaki isimler ile Swift uyuşmuyor demektir
                    print("Decoding Hatası (MG): \(error)")
                }
            }
        }.resume()
    }
    func performSaveMuscleGroup(group: MuscleGroup, isNew: Bool) {
        let urlString = isNew ? baseMgURL : "\(baseMgURL)/\(group.id ?? 0)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = isNew ? "POST" : "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var uploadGroup = group
        if isNew { uploadGroup.id = 0 }

        do {
            request.httpBody = try JSONEncoder().encode(uploadGroup)
        } catch { return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error { print("Save MG Error: \(error)"); return }
            DispatchQueue.main.async {
                self.fetchMuscleGroups()
            }
        }.resume()
    }

    func performDeleteMuscleGroup(id: Int) {
        guard let url = URL(string: "\(baseMgURL)/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error { print("Delete MG Error: \(error)"); return }
            DispatchQueue.main.async {
                self.fetchMuscleGroups()
                self.fetchExercises() // Gruplar silinince egzersiz listesini de tazele
            }
        }.resume()
    }
}
