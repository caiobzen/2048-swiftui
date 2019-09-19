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
            Moves()
        }
        .frame(minWidth: .zero,
               maxWidth: .infinity,
               minHeight: .zero,
               maxHeight: .infinity,
               alignment: .center)
        .background(Color.gameBackground)
        .edgesIgnoringSafeArea(.all)
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
            GameOverView(score: self.viewModel.score, moves: self.viewModel.numberOfMoves) {
                self.viewModel.reset()
            }
        }
    }
    
    private func Moves() -> some View {
        HStack {
            Text("moves: \(viewModel.numberOfMoves)").bold()
        }
        .font(.system(size: 16, weight: .regular, design: .rounded))
        .foregroundColor(.white50)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(GameEngine(), storage: LocalStorage()))
    }
}
