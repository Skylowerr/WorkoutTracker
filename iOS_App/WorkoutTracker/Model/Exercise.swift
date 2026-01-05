import Foundation

// MuscleGroup.swift
struct MuscleGroup: Identifiable, Codable {
    var id: Int?
    var groupName: String
    var yearEstablished: Int

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case groupName = "GroupName"
        case yearEstablished = "YearEstablished"
    }
}

// Exercise.swift
struct Exercise: Identifiable, Codable {
    var id: Int?
    var name: String
    var description: String
    var isCardio: Bool
    var sets: Int
    var reps: Int
    var muscleGroupID: Int

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case description = "Description"
        case isCardio = "IsCardio"
        case sets = "Sets"
        case reps = "Reps"
        case muscleGroupID = "MuscleGroupID"
    }
}
