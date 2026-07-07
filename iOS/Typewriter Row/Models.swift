import Foundation

struct Typewriter: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var year: String
    var condition: String
    var notes: String
    var dateAdded: Date = Date()
}
