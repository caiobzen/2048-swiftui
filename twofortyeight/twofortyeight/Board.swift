import SwiftUI

struct Board: View {
    @State var board: [[Int]] = [[]]

    var body: some View {
        VStack {
            ForEach(board, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { column in
                        Tile(column)
                    }.padding(1)
                }
            }
            }
            .padding(8)
            .background(Color(red: 183/255, green: 173/255, blue: 162/255))
            .cornerRadius(2)
    }
}

#if DEBUG
struct Board_Previews: PreviewProvider {
    static var previews: some View {
        Board(board: [
            [0,2,0,0],
            [0,0,4,8],
            [0,0,16,32],
            [0,0,0,256]
        ])
    }
}
#endif
