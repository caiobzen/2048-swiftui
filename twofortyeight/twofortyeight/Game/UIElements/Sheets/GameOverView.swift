import SwiftUI

struct GameOverView: View {
    let score: Int
    let action: () -> ()
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            VStack(alignment: .center, spacing: 16) {
                Text("😔 GAME OVER 😔")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .bold()
                
                Text("SCORE: \(score.description)")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(12)
            .background(Color(white: 0.5))
            .cornerRadius(6)
                                    
            ActionButton(title: "NEW GAME", action: action)
        }
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
