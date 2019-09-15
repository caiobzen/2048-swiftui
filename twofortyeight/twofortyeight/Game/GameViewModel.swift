import Combine
import UIKit

class GameViewModel: ObservableObject {
    private(set) var engine: Engine
    private(set) var storage: Storage
    
    @Published var isGameOver = false
    private(set) var addedTile: (Int, Int)? = nil {
        didSet { UIImpactFeedbackGenerator().impactOccurred() }
    }
    private(set) var score: Int = .zero {
        didSet { bestScore = max(bestScore, score) }
    }
    private(set) var bestScore: Int = .zero {
        didSet { storage.save(bestScore) }
    }
    private(set) var board: [[Int]] {
        willSet { boardHasChanged = !board.isEqual(newValue) }
        didSet { isGameOver = engine.isGameOver(board) }
    }
    private var boardHasChanged = false
    
    init(_ engine: Engine, storage: Storage) {
        self.engine = engine
        self.storage = storage
        self.board = engine.blankBoard
        self.bestScore = max(storage.bestScore, .zero)
    }
    
    func addNumber() {
        let result = engine.addNumber(board)
        board = result.newBoard
        addedTile = result.addedTile
    }
    
    func push(_ direction: Direction) {
        let result = engine.push(board, to: direction)
        board = result.newBoard
        score += result.scoredPoints
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
