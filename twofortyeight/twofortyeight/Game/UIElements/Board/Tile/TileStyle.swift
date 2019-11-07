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
            
        case .empty: return (Color(red: 197/255, green: 186/255, blue: 175/255, opacity: 1.0))
            
        case .two: return (Color(red: 235/255, green: 228/255, blue: 220/255, opacity: 1.0))
            
        case .four: return (Color(red: 233/255, green: 223/255, blue: 204/255, opacity: 1.0))
            
        case .eigth: return (Color(red: 225/255, green: 179/255, blue: 135/255, opacity: 1.0))
            
        case .sixteen: return (Color(red: 215/255, green: 151/255, blue: 112/255, opacity: 1.0))
            
        case .thirtyTwo: return (Color(red: 211/255, green: 131/255, blue: 105/255, opacity: 1.0))
            
        case .sixtyFour: return (Color(red: 214/255, green: 113/255, blue: 85/255, opacity: 1.0))
            
        case .max: return  (Color(red: 229/255, green: 204/255, blue: 132/255, opacity: 1.0))
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .two, .four: return                 (Color(red: 116/255, green: 110/255, blue: 103/255, opacity: 1.0))
        default: return .white
        }
    }
}
