import Combine

class BoardViewModel: ObservableObject {
    private(set) var engine: Engine
    private var boardHasChanged = false
    
    @Published private(set) var isGameOver = false
    @Published private(set) var board: [[Int]] {
        willSet { boardHasChanged = board != newValue }
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
        if boardHasChanged { addNumber() }
    }
    
    func reset() {
        board = engine.blankBoard
    }
}
