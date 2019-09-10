import SwiftUI

class GameViewController: UIHostingController<Board> {
    
    private let viewModel: BoardViewModel
    
    init(viewModel: BoardViewModel) {
        self.viewModel = viewModel
        super.init(rootView: Board(viewModel: viewModel))
        
        setupGestures()
        viewModel.addNumber()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestures() {
        view.addGestureRecognizer(SwipeGestureWithDirection(.left) { self.pushLeft() })
        view.addGestureRecognizer(SwipeGestureWithDirection(.right) { self.pushRight() })
        view.addGestureRecognizer(SwipeGestureWithDirection(.up) { self.pushUp() })
        view.addGestureRecognizer(SwipeGestureWithDirection(.down) { self.pushDown() })
    }
    
    @objc func pushLeft() {
        viewModel.push(.left)
    }
    
    @objc func pushRight() {
        viewModel.push(.right)
    }
    
    @objc func pushUp() {
        viewModel.push(.up)
    }
    
    @objc func pushDown() {
        viewModel.push(.down)
    }
}
