import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State var showMenu = false
    
    private let backgroundColor = Color(red: 251/255, green: 248/255, blue: 240/255)
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            HStack(alignment: .top) {
                YellowBlock()
                HStack(alignment: .top) {
                    VStack(alignment: .center, spacing: 10) {
                        ScoreBox(title: "SCORE", score: viewModel.score)
                        SmallActionButton(title: "MENU") { self.showMenu.toggle() }
                    }
                    ScoreBox(title: "BEST", score: viewModel.bestScore)
                }
            }
            
            Spacer()
            
            HStack (alignment: .center, spacing: 4) {
                Text("Join the numbers and get to the")
                Text("2048 tile!") .bold()
            }
            .font(.subheadline)
            .foregroundColor(.init(white: 0.4))

            Board(board: viewModel.board)
            Spacer()
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .center)
        .background(backgroundColor)
        .background(Menu())
        .background(GameOver())
    }
}

extension GameView {
    private func Menu() -> some View {
        EmptyView().sheet(isPresented: $showMenu) {
            MenuView {
                self.viewModel.reset()
                self.showMenu.toggle()
            }
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
        GameView(viewModel: GameViewModel(GameEngine()))
    }
}
