import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: BoardViewModel
    
    var body: some View {
        Board(board: viewModel.board)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: BoardViewModel(GameEngine()))
    }
}
