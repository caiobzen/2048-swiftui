import Combine

class BoardViewModel: ObservableObject {
    private(set) var engine: Engine
    @Published var isGameOver = false
    @Published var didChanged = false
    
    @Published private(set) var board: [[Int]] {
        willSet { didChanged = board != newValue }
        didSet { isGameOver = engine.isGameOver(board) }
    }
    
    init(_ engine: Engine) {
        self.engine = engine
        self.board = engine.blankBoard
    }
    
    func addNumber() {
        board = engine.addNumber(board)
    }
    
    func push(_ direction: Direction) {
        board = engine.push(board, to: direction)
    }
    
    func reset() {
        board = engine.blankBoard
    }
}
