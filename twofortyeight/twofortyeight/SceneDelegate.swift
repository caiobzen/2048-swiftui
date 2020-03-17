import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let engine = GameEngine()
            let storage = LocalStorage()
            let stateTracker = GameStateTracker(initialState: (storage.board ?? engine.blankBoard, storage.score))
            window.rootViewController = GameViewController(viewModel: GameViewModel(engine, storage: storage, stateTracker: stateTracker))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

