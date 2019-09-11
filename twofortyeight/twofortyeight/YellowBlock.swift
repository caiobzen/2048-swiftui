import SwiftUI

struct YellowBlock: View {
    let title = "2048"
    
    var body: some View {
        Text(title)
        .font(.largeTitle)
        .bold()
        .frame(width: 120, height: 120)
        .background(Color(red: 224/255, green: 196/255, blue: 95/255))
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

struct YellowBlock_Previews: PreviewProvider {
    static var previews: some View {
        YellowBlock()
    }
}
