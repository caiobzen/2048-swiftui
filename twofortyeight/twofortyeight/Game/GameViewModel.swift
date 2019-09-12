import Combine
import UIKit

class GameViewModel: ObservableObject {
    private(set) var engine: Engine
    private(set) var storage: Storage
    private var boardHasChanged = false
    
    @Published var isGameOver = false
    @Published var addedTile: (Int, Int)? = nil {
        didSet { UIImpactFeedbackGenerator().impactOccurred() }
    }
    @Published private(set) var score = 0 {
        didSet { bestScore = max(bestScore, score) }
    }
    @Published private(set) var bestScore = 0 {
        didSet { storage.save(bestScore) }
    }
    @Published private(set) var board: [[Int]] {
        willSet { boardHasChanged = !board.isEqual(newValue) }
        didSet { isGameOver = engine.isGameOver(board) }
    }
    
    init(_ engine: Engine, storage: Storage) {
        self.engine = engine
        self.storage = storage
        self.board = engine.blankBoard
        self.bestScore = max(storage.bestScore, 0)
    }
    
    func addNumber() {
        let result = engine.addNumber(board)
        board = result.newBoard
        addedTile = result.addedTile
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
        addNumber()
    }
    
    func eraseBestScore() {
        bestScore = .zero
    }
}
