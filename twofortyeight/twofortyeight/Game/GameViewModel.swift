import Combine
import UIKit

class GameViewModel: ObservableObject {
    private(set) var engine: Engine
    private(set) var storage: Storage
    private(set) var stateTracker: StateTracker
  
    @Published var isGameOver = false
    private(set) var addedTile: (Int, Int)? = nil {
        didSet { UIImpactFeedbackGenerator().impactOccurred() }
    }
    private(set) var bestScore: Int = .zero {
        didSet { storage.save(bestScore: bestScore) }
    }
    
    var numberOfMoves: Int {
        return stateTracker.statesCount - 1
    }
    var isUndoable: Bool {
        return stateTracker.isUndoable
    }
    var state: GameState {
        didSet {
            bestScore = max(bestScore, state.score)
            storage.save(score: state.score)
            isGameOver = engine.isGameOver(state.board)
            storage.save(board: state.board)
        }
    }
    
    init(_ engine: Engine, storage: Storage, stateTracker: StateTracker) {
        self.engine = engine
        self.storage = storage
        self.stateTracker = stateTracker
        self.state = stateTracker.last
        self.bestScore = max(storage.bestScore, storage.score)
    }
    
    func start() {
        if state.board.isMatrixEmpty { reset() }
    }
    
    func addNumber() {
        let result = engine.addNumber(state.board)
        state = stateTracker.updateCurrent(with: result.newBoard)
        addedTile = result.addedTile
    }
    
    func push(_ direction: Direction) {
        let result = engine.push(state.board, to: direction)
        let boardHasChanged = !state.board.isEqual(result.newBoard)
        state = stateTracker.next(with: (result.newBoard, state.score + result.scoredPoints))
        if boardHasChanged {
            addNumber()
        }
    }
    
    func undo() {
        state = stateTracker.undo()
    }
    
    func reset() {
        state = stateTracker.reset(with: (engine.blankBoard, .zero))
        addNumber()
    }
    
    func eraseBestScore() {
        bestScore = .zero
    }
    
}
