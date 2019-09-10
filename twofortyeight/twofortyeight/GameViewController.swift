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
        let left = UISwipeGestureRecognizer(target: self, action: #selector(pushLeft))
        left.direction = .left
        let right = UISwipeGestureRecognizer(target: self, action: #selector(pushRight))
        right.direction = .right
        let up = UISwipeGestureRecognizer(target: self, action: #selector(pushUp))
        up.direction = .up
        let down = UISwipeGestureRecognizer(target: self, action: #selector(pushDown))
        down.direction = .down
        
        view.addGestureRecognizer(left)
        view.addGestureRecognizer(right)
        view.addGestureRecognizer(up)
        view.addGestureRecognizer(down)
    }
    
    @objc func pushLeft() {
        viewModel.push(.left)
        if viewModel.didChanged {
            viewModel.addNumber()
        }
    }
    @objc func pushRight() {
        viewModel.push(.right)
        if viewModel.didChanged {
            viewModel.addNumber()
        }
    }
    @objc func pushUp() {
        viewModel.push(.up)
        if viewModel.didChanged {
            viewModel.addNumber()
        }
    }
    @objc func pushDown() {
        viewModel.push(.down)
        if viewModel.didChanged {
            viewModel.addNumber()
        }
    }
}
