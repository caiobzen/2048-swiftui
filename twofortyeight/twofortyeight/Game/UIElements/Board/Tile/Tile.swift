import SwiftUI

struct Tile: View {
    let value: Int
    let wasAdded: Bool
    private let style: TileStyle
    private let title: String
    private let size: CGFloat = 70
    
    init(_ value: Int, wasAdded: Bool = false) {
        self.wasAdded = wasAdded
        self.value = value
        style = TileStyle(value)
        title = value == 0 ? "" : value.description
    }
    
    private var fontSize: CGFloat {
        switch value.digits {
        case 1, 2:
            return 30
        case 3:
            return 28
        default:
            return 22
        }
    }
    
    private var shadowColor: Color {
        value == 2048 ? .yellow : .clear
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: fontSize, weight: .black, design: .rounded))
            .foregroundColor(style.foregroundColor)
            .frame(width: size, height: size)
            .background(style.backgroundColor)
            .cornerRadius(3)
            .shadow(color: shadowColor, radius: 4, x: 0, y: 0)
            .animation(wasAdded ? .easeIn : .none)
    }
}

#if DEBUG
struct Tile_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Tile(0)
            Tile(2)
            Tile(4)
            Tile(8)
            Tile(16)
            Tile(32)
            Tile(64)
            Tile(128)
            Tile(2048)
        }
        .previewLayout(.fixed(width: 100, height: 100))
    }
}
#endif
