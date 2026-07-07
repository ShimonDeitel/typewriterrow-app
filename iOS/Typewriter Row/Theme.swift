import SwiftUI

enum Theme {
    static let accent = Color(red: 0.6902, green: 0.5373, blue: 0.4078)
    static let background = Color(red: 0.0941, green: 0.0706, blue: 0.0627)
    static let card = Color(red: 0.1451, green: 0.1098, blue: 0.0941)
    static let textPrimary = Color(red: 0.9608, green: 0.9255, blue: 0.8941)
    static let textMuted = Color(red: 0.7882, green: 0.6784, blue: 0.5804)

    static let titleFont = Font.system(.title2, design: .serif).weight(.bold)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let labelFont = Font.system(.caption, design: .rounded).weight(.semibold)
}
