import XCTest
import SwiftUI
@testable import twofortyeight

class GameViewModelTests: XCTestCase {
    
    var sut: GameViewModel!
    
    override func setUp() {
        sut = GameViewModel(GameEngine(), storage: MockStorage())
    }
    
    func test_can_reset_board() {
        sut.addNumber()
        sut.addNumber()
        sut.addNumber()
        
        sut.reset()
        
        let number = sut.board.flatMap{ $0 }.reduce(0, +)
        XCTAssertTrue(number > 0)
    }
    
    func test_can_init_with_blank_board() {
        let storage = MockStorage()
        let engine = GameEngine()
        storage.savedBoard = nil
        
        sut = GameViewModel(engine, storage: storage)
        
        XCTAssertEqual(sut.board, engine.blankBoard)
    }
    
    func test_can_add_number_to_board() {
        sut.addNumber()
        
        let hasNumber = sut.board.flatMap{ $0 }.reduce(0, +) != 0
        XCTAssertTrue(hasNumber)
    }
    
    func test_can_push_numbers_to_right() {
        let sut = GameViewModel(GameEngineStub(), storage: MockStorage())

        sut.push(.right)
        
        XCTAssertEqual(sut.board[0][3], 4)
        XCTAssertEqual(sut.board[1][3], 8)
        XCTAssertEqual(sut.board[2][3], 16)
        XCTAssertEqual(sut.board[3][3], 32)
    }
    
    func test_can_push_numbers_to_left() {
        let sut = GameViewModel(GameEngineStub(), storage: MockStorage())
        
        sut.push(.left)
        
        XCTAssertEqual(sut.board[0][0], 4)
        XCTAssertEqual(sut.board[1][0], 8)
        XCTAssertEqual(sut.board[2][0], 16)
        XCTAssertEqual(sut.board[3][0], 32)
    }
    
    func test_can_push_numbers_to_up() {
        let sut = GameViewModel(GameEngineStub(), storage: MockStorage())
        
        sut.push(.up)

        XCTAssertEqual(sut.board[0][0], 8)
        XCTAssertEqual(sut.board[0][1], 2)
        XCTAssertEqual(sut.board[0][2], 4)
        XCTAssertEqual(sut.board[0][3], 2)
        
        XCTAssertEqual(sut.board[1][0], 16)
        XCTAssertEqual(sut.board[1][1], 4)
        XCTAssertEqual(sut.board[1][2], 16)
        XCTAssertEqual(sut.board[1][3], 8)
    }
    
    func test_can_push_numbers_down() {
        let sut = GameViewModel(GameEngineStub(), storage: MockStorage())
        
        sut.push(.down)

        XCTAssertEqual(sut.board[2][0], 8)
        XCTAssertEqual(sut.board[2][1], 2)
        XCTAssertEqual(sut.board[2][2], 4)
        XCTAssertEqual(sut.board[2][3], 2)
        
        XCTAssertEqual(sut.board[3][0], 16)
        XCTAssertEqual(sut.board[3][1], 4)
        XCTAssertEqual(sut.board[3][2], 16)
        XCTAssertEqual(sut.board[3][3], 8)
    }
    
    func test_can_tell_if_the_game_is_over() {
        let sut = newViewModelStub()
        sut.setGameOver()
        
        XCTAssertTrue(sut.engine.isGameOver(sut.board))
    }
    
    func test_can_score() {
        let sut = newViewModelStub()
        sut.setCanScoreFour()
        
        sut.push(.right)
        
        XCTAssertEqual(sut.score, 4)
    }
    
    func test_can_save_best_score() {
        let sut = newViewModelStub()
        sut.setCanScoreFour()
        
        sut.push(.right)
        sut.reset()
        
        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.bestScore, 4)
    }
    
    private func newViewModelStub() -> GameViewModelStub {
        GameViewModelStub(GameEngineStub(), storage: MockStorage())
    }
}

class MockStorage: Storage {
    var savedScore = 0
    var savedBestScore = 0
    var savedBoard: Matrix? = GameEngineStub().blankBoard
    
    func save(bestScore: Int) {
        savedBestScore = bestScore
    }
    
    func save(score: Int) {
        savedScore = score
    }
    
    func save(board: Matrix) {
        savedBoard = board
    }
    
    var score: Int {
        return savedScore
    }
    
    var bestScore: Int {
        return savedBestScore
    }
    
    var board: Matrix? {
        return savedBoard
    }
}

class GameViewModelStub: GameViewModel {
    private var _board = [[Int]]()
    
    override var board: [[Int]] {
        return _board
    }
    
    func setGameOver() {
        _board = [
            [2,16,2,16],
            [4,8,4,8],
            [8,4,8,4],
            [16,2,16,2]
        ]
    }

    func setCanScoreFour() {
        _board = [
            [2,2,0,0],
            [0,0,0,0],
            [0,0,0,0],
            [0,0,0,0]
        ]
    }
}

class GameEngineStub: Engine {
    func isGameOver(_ board: Matrix) -> Bool {
        GameEngine().isGameOver(board)
    }
    
    func addNumber(_ board: Matrix) -> (newBoard: Matrix, addedTile: (Int, Int)?) {
        GameEngine().addNumber(board)
    }
    
    func push(_ board: Matrix, to direction: Direction) -> (newBoard: Matrix, scoredPoints: Int) {
        GameEngine().push(board, to: direction)
    }
    
    let blankBoard: [[Int]] = [
        [0,2,0,2],
        [0,4,4,0],
        [8,0,0,8],
        [16,0,16,0]
    ]
}
