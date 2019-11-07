import SwiftUI

struct Board: View {
    var board: Matrix
    var addedTile: (Int, Int)? = nil
    
    private func wasAdded(row: Int, column: Int) -> Bool {
        addedTile?.0 == row && addedTile?.1 == column
    }
    
    var body: some View {
        VStack {
            ForEach(0..<self.board.count, id: \.self) { row in
                HStack {
                    ForEach(0..<self.board[row].count, id: \.self) { column in
                        return Tile(self.board[row, column], wasAdded: self.wasAdded(row: row, column: column))
                    }
                }
                .padding(4)
            }
        }
        .padding(8)
        .background(Color(red: 183/255, green: 173/255, blue: 162/255, opacity: 1.0))
        .cornerRadius(4)
    }
}

#if DEBUG
struct Board_Previews: PreviewProvider {
    static var previews: some View {
        Board(board: GameEngine().blankBoard)
    }
}
#endif
