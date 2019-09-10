import SwiftUI
import Foundation

class GameViewController: UIHostingController<GameView> {
    
    private let viewModel: BoardViewModel
    
    init(viewModel: BoardViewModel) {
        self.viewModel = viewModel
        super.init(rootView: GameView(viewModel: viewModel))
        
        setupGestures()
        viewModel.addNumber()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestures() {
        view.addGestureRecognizer(SwipeGestureWithDirection(.left) { [weak self] in
            self?.viewModel.push(.left)
        })
        view.addGestureRecognizer(SwipeGestureWithDirection(.right) { [weak self] in
            self?.viewModel.push(.right)
        })
        view.addGestureRecognizer(SwipeGestureWithDirection(.up) { [weak self] in
            self?.viewModel.push(.up)
        })
        view.addGestureRecognizer(SwipeGestureWithDirection(.down) { [weak self] in
            self?.viewModel.push(.down)
        })
    }
}
