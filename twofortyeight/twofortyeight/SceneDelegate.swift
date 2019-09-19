import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let engine = GameEngine()
            let storage = LocalStorage()
            window.rootViewController = GameViewController(viewModel: GameViewModel(engine, storage: storage))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

