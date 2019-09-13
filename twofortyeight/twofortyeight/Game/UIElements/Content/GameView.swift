import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State var showMenu = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Header(score: viewModel.score, bestScore: viewModel.bestScore) {
                self.showMenu.toggle()
            }
            GoalText()
            Board(board: viewModel.board, addedTile: viewModel.addedTile)
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .center)
            .background(Color.gameBackground)
        .background(Menu())
        .background(GameOver())
    }
}

extension GameView {
    private func Menu() -> some View {
        EmptyView().sheet(isPresented: $showMenu) {
            MenuView(newGameAction: {
                self.viewModel.reset()
                self.showMenu.toggle()
            }, resetScoreAction: {
                self.viewModel.eraseBestScore()
                self.showMenu.toggle()
            })
        }
    }
    
    private func GameOver() -> some View {
        EmptyView().sheet(isPresented: $viewModel.isGameOver) {
            GameOverView(score: self.viewModel.score) {
                self.viewModel.reset()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(GameEngine(), storage: LocalStorage()))
    }
}
