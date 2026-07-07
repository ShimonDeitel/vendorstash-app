import Foundation

struct GiftCard: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var store: String
    var balance: Double
    var originalValue: Double
    var expiration: Date
    var cardCode: String

    init(id: UUID = UUID(), store: String = "", balance: Double = 0.0, originalValue: Double = 0.0, expiration: Date = Date(), cardCode: String = "") {
        self.id = id
        self.store = store
        self.balance = balance
        self.originalValue = originalValue
        self.expiration = expiration
        self.cardCode = cardCode
    }
}
