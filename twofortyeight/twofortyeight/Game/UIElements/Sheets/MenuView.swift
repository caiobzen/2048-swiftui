import SwiftUI

struct MenuView: View {
    let newGameAction: () -> ()
    let resetScoreAction: () -> ()
    @State private var showConfirmation = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            menuTitle
                .accessibility(identifier: "menuLabel")
            ActionButton(title: "NEW GAME", action: newGameAction)
                .accessibility(identifier: "newGameButton")
            ActionButton(title: "RESET BEST SCORE") { self.showConfirmation.toggle() }
                .accessibility(identifier: "resetBestScoreButton")
        }
        .alert(isPresented: $showConfirmation) { confirmationAlert }
    }
}

extension MenuView {
    private var menuTitle: Text {
        Text("MENU")
            .font(.system(size: 60, weight: .black, design: .rounded))
            .fontWeight(.black)
    }
    
    private var confirmationAlert: Alert {
        Alert(title: confirmationMessage,
              primaryButton: resetScoreAlertButton,
              secondaryButton: .cancel())
    }
    
    private var confirmationMessage: Text {
        Text("Are you sure you want to erase your best score?")
    }
    
    private var resetScoreAlertButton: Alert.Button {
        .default(Text("Yeah, whatever"), action: self.resetScoreAction)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuView(newGameAction:{}){}
        }
    }
}
