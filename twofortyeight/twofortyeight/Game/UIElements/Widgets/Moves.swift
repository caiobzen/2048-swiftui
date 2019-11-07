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
        .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.5))
    }
}
struct Moves_Previews: PreviewProvider {
    static var previews: some View {
        Moves(123)
    }
}
