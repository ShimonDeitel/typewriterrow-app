import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published private(set) var items: [Typewriter] = []
    @Published var isPro: Bool = false

    static let freeLimit = 20

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("typewriterrow_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Typewriter) {
        items.append(item)
        save()
    }

    func update(_ item: Typewriter) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Typewriter) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Typewriter].self, from: data) {
            items = decoded
        } else {
            items = [
        Typewriter(name: "Royal Quiet De Luxe", year: "1948", condition: "Restored", notes: "New platen"),
        Typewriter(name: "Underwood No. 5", year: "1929", condition: "Needs Work", notes: "Sticky keys"),
        Typewriter(name: "Olivetti Lettera 22", year: "1954", condition: "Working", notes: "Travel case included"),
        Typewriter(name: "Smith Corona Skyriter", year: "1952", condition: "Restored", notes: "Repainted"),
        Typewriter(name: "Hermes 3000", year: "1961", condition: "Working", notes: "Fresh ribbon")
            ]
            save()
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }
}
