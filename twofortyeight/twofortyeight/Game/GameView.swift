import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State var showMenu = false
    
    private let backgroundColor = Color(red: 251/255, green: 248/255, blue: 240/255)
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()

            ActionButton(title: "MENU") {
                self.showMenu.toggle()
            }
            
            Spacer()
            
            HStack(alignment: .top) {
                YellowBlock()
                HStack {
                    ScoreBox(title: "SCORE", score: viewModel.score)
                    ScoreBox(title: "BEST", score: viewModel.bestScore)
                }
            }
            
            Spacer()
            Board(board: viewModel.board)
            Spacer()
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .center)
        .background(backgroundColor)
        .sheet(isPresented: $viewModel.isGameOver) {
            GameOverView(score: self.viewModel.score) {
                self.viewModel.reset()
            }
        }
        .popover(isPresented: $showMenu) {
            MenuView {
                self.viewModel.reset()
                self.showMenu.toggle()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(GameEngine()))
    }
}
