import SwiftUI

struct ScoreBox: View {
    private let backgroundColor = Color(red: 183/255, green: 173/255, blue: 162/255)
    
    let title: String
    let score: Int
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.init(white: 0.9))
                
            Text(score.description)
                .font(.title)
                .bold()
                .truncationMode(.tail)
                .foregroundColor(.white)
        }
        .frame(width: 80, height: 60)
        .padding(8)
        .background(backgroundColor)
        .cornerRadius(6)
    }
}

struct ScoreBox_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBox(title: "SCORE", score: 4)
    }
}
