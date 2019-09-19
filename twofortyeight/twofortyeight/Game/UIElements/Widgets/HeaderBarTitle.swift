import SwiftUI

struct HeaderBarTitle: View {
    let title: String
    let size: CGFloat = 60
    
    var body: some View {
        Group {
            Text(title)
                .font(.system(size: size, weight: .black, design: .rounded))
                .foregroundColor(.white)
                .fontWeight(.black)
                .minimumScaleFactor(0.5)
                .padding(.horizontal, 16)
                .accessibility(identifier: title)
                .shadow(radius: 1)
        }
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
        .background(Color.customYellow)
    }
}

struct HeaderBarTitle_Previews: PreviewProvider {
    static var previews: some View {
        HeaderBarTitle(title: "MENU")
    }
}
