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
            .font(.title)
            .fontWeight(.black)
            .padding(4)
            .minimumScaleFactor(0.4)
            .frame(width: 50, height: 50)
            .background(style.backgroundColor)
            .foregroundColor(style.foregroundColor)
            .cornerRadius(2)
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
        .previewLayout(.fixed(width: 80, height: 80))
    }
}
#endif
