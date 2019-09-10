import Combine

class BoardViewModel: ObservableObject {
    private(set) var engine: Engine
    @Published private(set) var board: [[Int]]
    
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
    
    func isGameOver() -> Bool {
        return engine.isGameOver(board)
    }
}
