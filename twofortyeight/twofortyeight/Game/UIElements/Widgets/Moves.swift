import SwiftUI

struct Moves: View {
    let moves: Int
    
    init(_ moves: Int) {
        self.moves = moves
    }
    
    var body: some View {
        HStack {
            Text("moves: \(moves)").bold()
        }
        .font(.system(size: 16, weight: .regular, design: .rounded))
        .foregroundColor(.white50)
    }
}
struct Moves_Previews: PreviewProvider {
    static var previews: some View {
        Moves(123)
    }
}
