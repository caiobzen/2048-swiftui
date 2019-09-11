import SwiftUI

struct MenuView: View {
    let newGameAction: () -> ()
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("MENU")
                .font(.largeTitle)
                .fontWeight(.black)
                .bold()
            
            ActionButton(title: "NEW GAME", action: newGameAction)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuView { }
        }
    }
}
