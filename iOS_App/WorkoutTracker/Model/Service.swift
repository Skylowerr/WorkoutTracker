import Foundation

class APIService {
    // Port numarasını C# projen hangisinde çalışıyorsa ona sabitle (Örn: 5099 veya 5154)
    private let exerciseURL = "http://127.0.0.1:5099/api/exercises"
    private let muscleGroupURL = "http://127.0.0.1:5099/api/musclegroups"

    func fetchExercises(completion: @escaping (Result<[Exercise], Error>) -> Void) {
        guard let url = URL(string: exerciseURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode([Exercise].self, from: data)
                DispatchQueue.main.async { completion(.success(decoded)) }
            } catch { completion(.failure(error)) }
        }.resume()
    }

    // BU EKSİKTİ: Kas gruplarını çekmek için yeni metod
    func fetchMuscleGroups(completion: @escaping (Result<[MuscleGroup], Error>) -> Void) {
        guard let url = URL(string: muscleGroupURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode([MuscleGroup].self, from: data)
                DispatchQueue.main.async { completion(.success(decoded)) }
            } catch { completion(.failure(error)) }
        }.resume()
    }
}
