import SwiftUI

/// gift-wrap purple with gold ribbon accent
enum Theme {
    static let accent = Color(red: 0.5569, green: 0.2667, blue: 0.6784)
    static let accentSecondary = Color(red: 0.9608, green: 0.8431, blue: 0.4314)
    static let background = Color(red: 0.0863, green: 0.0549, blue: 0.1098)
    static let cardBackground = background.opacity(0.6)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
