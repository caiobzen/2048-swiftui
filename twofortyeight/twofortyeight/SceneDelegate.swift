import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var engine: GameEngine!
    var viewModel: BoardViewModel!
    var board: Board!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            engine = GameEngine()
            viewModel = BoardViewModel(engine)
            board = Board(viewModel: viewModel)
            window.rootViewController = UIHostingController(rootView: board)
            
            let left = UISwipeGestureRecognizer(target: self, action: #selector(pushLeft))
            left.direction = .left
            let right = UISwipeGestureRecognizer(target: self, action: #selector(pushRight))
            right.direction = .right
            let up = UISwipeGestureRecognizer(target: self, action: #selector(pushUp))
            up.direction = .up
            let down = UISwipeGestureRecognizer(target: self, action: #selector(pushDown))
            down.direction = .down
            
            window.rootViewController?.view.addGestureRecognizer(left)
            window.rootViewController?.view.addGestureRecognizer(right)
            window.rootViewController?.view.addGestureRecognizer(up)
            window.rootViewController?.view.addGestureRecognizer(down)
            
            viewModel.addNumber()
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    @objc func pushLeft() {
        viewModel.push(.left)
        viewModel.addNumber()
    }
    @objc func pushRight() {
        viewModel.push(.right)
        viewModel.addNumber()
    }
    @objc func pushUp() {
        viewModel.push(.up)
        viewModel.addNumber()
    }
    @objc func pushDown() {
        viewModel.push(.down)
        viewModel.addNumber()
    }
}

