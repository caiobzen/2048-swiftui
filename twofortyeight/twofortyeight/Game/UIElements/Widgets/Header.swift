import SwiftUI

struct Header: View {
    let score: Int
    let bestScore: Int
    let scoreLabel = "SCORE"
    let bestScoreLabel = "BEST"
    let menuAction: () -> Void
    let undoAction: () -> Void
    var undoEnabled: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            YellowBlock()
            HStack(alignment: .top) {
                VStack(alignment: .center, spacing: 10) {
                    ScoreBox(title: scoreLabel, score:score)
                    SmallActionButton(title: "MENU", action: self.menuAction, enabled: true)
                        .accessibility(identifier: "menuButton")
                }
                VStack(alignment: .center, spacing: 10) {
                    ScoreBox(title: bestScoreLabel, score: bestScore)
                    SmallActionButton(title: "UNDO", action: self.undoAction, enabled: undoEnabled)
                    .accessibility(identifier: "undoButton")
                }
            }
        }
    }
}
struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(score: 10, bestScore: 12345, menuAction: {
            print("tapped on menu")
        }, undoAction: {
            print("tapped on undo")
        }, undoEnabled: false)
    }
}
