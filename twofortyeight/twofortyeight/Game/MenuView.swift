import SwiftUI

struct MenuView: View {
    let newGameAction: () -> ()
    
    var body: some View {
        VStack {
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
        MenuView { }
    }
}
