import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let engine = GameEngine()
            let board = Board(board: engine.blankBoard)
            window.rootViewController = UIHostingController(rootView: board)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

