import SwiftUI

struct Board: View {
    var board: Matrix
    private let backgroundColor = Color(red: 183/255, green: 173/255, blue: 162/255)
    
    var body: some View {
        VStack {
            VStack {
                ForEach(board, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { Tile($0) }
                    }
                    .padding(3)
                }
            }
            .background(backgroundColor)
            .padding(6)
            .cornerRadius(3)
        }
    }
}

#if DEBUG
struct Board_Previews: PreviewProvider {
    static var previews: some View {
        Board(board: GameEngine().blankBoard)
    }
}
#endif
