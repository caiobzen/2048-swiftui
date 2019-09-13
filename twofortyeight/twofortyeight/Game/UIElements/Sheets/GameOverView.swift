import SwiftUI

struct GameOverView: View {
    let score: Int
    let action: () -> ()
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            VStack(alignment: .center, spacing: 16) {
                gameOverTitleGroup
                scoreLabel
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(Color.white50)
            .cornerRadius(6)
                                    
            ActionButton(title: "NEW GAME", action: action)
        }
    }
}

extension GameOverView {
    private var gameOverTitleGroup: some View {
        Group {
            Text("😔")
            Text("GAME OVER")
        }.font(.system(size: 40, weight: .black,design: .rounded))
    }
    
    private var scoreLabel: Text {
        Text("SCORE: \(score.description)")
            .font(.system(size: 30, weight: .black, design: .rounded))
            .foregroundColor(.white)
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameOverView(score: 123) { }
                .environment(\.colorScheme, .light)
            
            GameOverView(score: 123) { }
                .environment(\.colorScheme, .dark)
        }
    }
}
