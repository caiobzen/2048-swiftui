import SwiftUI

struct Tile: View {
    let value: Int
    private let style: TileStyle
    private let title: String
    
    init(_ value: Int) {
        self.value = value
        style = TileStyle(value)
        title = value == 0 ? "" : value.description
    }
    
    var body: some View {
        Text(title)
            .fontWeight(.black)
            .minimumScaleFactor(0.4)
            .font(.largeTitle)
            .padding(4)
            .frame(width: 70, height: 70)
            .background(style.backgroundColor)
            .foregroundColor(style.foregroundColor)
            .cornerRadius(3)
    }
}

#if DEBUG
struct Tile_Previews: PreviewProvider {
    static var previews: some View {
        Group {
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
