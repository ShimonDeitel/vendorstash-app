import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [GiftCard] = []
    @Published var isPro: Bool = false

    /// Free tier allows this many entries. Seed data below is always fewer than this
    /// so a fresh install never opens straight into the paywall.
    static let freeLimit = 20

    private let fileName = "vendorstash_items.json"

    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir.appendingPathComponent(fileName)
    }

    init() {
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([GiftCard].self, from: data) else {
            items = Self.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Self.freeLimit
    }

    @discardableResult
    func add(_ item: GiftCard) -> Bool {
        guard canAddMore else { return false }
        items.append(item)
        save()
        return true
    }

    func update(_ item: GiftCard) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: GiftCard) {
        items.removeAll { $0.id == item.id }
        save()
    }

    static func seedData() -> [GiftCard] {
        [
        GiftCard(store: "Trader Joe's", balance: 3.5, originalValue: 3.5, expiration: Date().addingTimeInterval(-259200), cardCode: "****1234"),
        GiftCard(store: "Whole Foods", balance: 5.75, originalValue: 5.75, expiration: Date().addingTimeInterval(-518400), cardCode: "****5678"),
        GiftCard(store: "Safeway", balance: 8.0, originalValue: 8.0, expiration: Date().addingTimeInterval(-777600), cardCode: "****1234"),
        GiftCard(store: "Trader Joe's", balance: 10.25, originalValue: 10.25, expiration: Date().addingTimeInterval(-1036800), cardCode: "****5678")
        ]
    }
}
