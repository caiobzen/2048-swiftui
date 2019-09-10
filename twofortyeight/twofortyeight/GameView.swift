import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: BoardViewModel
    private let backgroundColor = Color(red: 251/255, green: 248/255, blue: 240/255)
    
    var body: some View {
        VStack(alignment: .center) {
            if viewModel.isGameOver {
                Text("GAME OVER!")
                    .foregroundColor(.black)
            }
            
            Text("SCORE: \(viewModel.score)")
                .foregroundColor(.black)
                .bold()
                .font(.title)
            
            Board(board: viewModel.board)
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .center)
        .background(backgroundColor)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: BoardViewModel(GameEngine()))
    }
}
