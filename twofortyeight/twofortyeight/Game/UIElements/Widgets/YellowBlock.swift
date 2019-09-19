import SwiftUI

struct YellowBlock: View {
    private let title = "2048"
    private let size: CGFloat = 120
    
    var body: some View {
        Text(title)
            .font(.system(size: 34, weight: .black, design: .rounded))
            .frame(width: size, height: size)
            .background(Color.customYellow)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

struct YellowBlock_Previews: PreviewProvider {
    static var previews: some View {
        YellowBlock()
    }
}
