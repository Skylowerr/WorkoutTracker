import Foundation

class APIService {
    private let exerciseURL = "BASE_URL_HERE"
    private let muscleGroupURL = "BASE_URL_HERE"

    //Verileri internetten çektiği için biraz beklememiz gerektiğini söylüyoruz
    func fetchExercises(completion: @escaping (Result<[Exercise], Error>) -> Void) {
        guard let url = URL(string: exerciseURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in //Sunucuya gidip dataları çeker
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode([Exercise].self, from: data)
                DispatchQueue.main.async { completion(.success(decoded)) } //Main UI'yı günceller veri geldiği zaman
            } catch { completion(.failure(error)) }
        }.resume() //İstek internete çıkar
    }

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
