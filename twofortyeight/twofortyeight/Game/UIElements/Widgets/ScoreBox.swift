import SwiftUI

struct ScoreBox: View {
    let title: String
    let score: Int
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundColor(.init(white: 0.9))
            
            Text(score.description)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .minimumScaleFactor(0.9)
                .truncationMode(.tail)
                .foregroundColor(.white)
                .accessibility(identifier: "\(title.lowercased())Value")
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 8)
        .background(Color.boardBackground)
        .cornerRadius(6)
    }
}

struct ScoreBox_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBox(title: "SCORE", score: 1234)
    }
}
