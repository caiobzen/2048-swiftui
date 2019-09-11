import Combine

class GameViewModel: ObservableObject {
    private(set) var engine: Engine
    private var boardHasChanged = false
    
    @Published private(set) var isGameOver = false
    @Published private(set) var score = 0 {
        didSet {
           bestScore = max(bestScore, score)
        }
    }
    @Published private(set) var bestScore = 0
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
        board = engine.push(board, to: direction) { [weak self] score in
            self?.score += score
        }
        
        if boardHasChanged { addNumber() }
    }
    
    func reset() {
        board = engine.blankBoard
        score = .zero
    }
}
