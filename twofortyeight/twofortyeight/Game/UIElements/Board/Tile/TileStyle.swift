import SwiftUI

enum TileStyle {
    case empty
    case two
    case four
    case eigth
    case sixteen
    case thirtyTwo
    case sixtyFour
    case max
    
    init(_ value: Int) {
        switch value {
        case 0: self = .empty
        case 2: self = .two
        case 4: self = .four
        case 8: self = .eigth
        case 16: self = .sixteen
        case 32: self = .thirtyTwo
        case 64: self = .sixtyFour
        default: self = .max
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .empty: return .tileEmpty
        case .two: return .tileTwo
        case .four: return .tileFour
        case .eigth: return .tileEight
        case .sixteen: return .tileSixteen
        case .thirtyTwo: return .tileThirtyTwo
        case .sixtyFour: return .tileSixtyFour
        case .max: return .tileMax
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .two, .four: return .tileDarkTitle
        default: return .white
        }
    }
}
