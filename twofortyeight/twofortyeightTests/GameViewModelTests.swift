import XCTest
import SwiftUI
@testable import twofortyeight

class GameViewModelTests: XCTestCase {
    
    func test_can_create_viewmodel() {
        let engine = GameEngine()
        let viewModel = GameViewModel(engine)
        
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel.engine)
        XCTAssertEqual(viewModel.board, engine.blankBoard)
    }
    
    func test_can_reset_board() {
        let engine = GameEngineStub()
        let viewModel = GameViewModel(engine)
        
        viewModel.reset()
        
        XCTAssertEqual(viewModel.board, engine.blankBoard)
    }
    
    func test_can_add_number_to_board() {
        let engine = GameEngine()
        let viewModel = GameViewModel(engine)
        
        viewModel.addNumber()
        
        let hasNumber = viewModel.board.flatMap{ $0 }.reduce(0, +) != 0
        XCTAssertTrue(hasNumber)
    }
    
    func test_can_push_numbers_to_right() {
        let engine = GameEngineStub()
        let viewModel = GameViewModel(engine)
        
        viewModel.push(.right)
        
        XCTAssertEqual(viewModel.board[0][3], 4)
        XCTAssertEqual(viewModel.board[1][3], 8)
        XCTAssertEqual(viewModel.board[2][3], 16)
        XCTAssertEqual(viewModel.board[3][3], 32)
    }
    
    func test_can_push_numbers_to_left() {
        let engine = GameEngineStub()
        let viewModel = GameViewModel(engine)
        
        viewModel.push(.left)
        
        XCTAssertEqual(viewModel.board[0][0], 4)
        XCTAssertEqual(viewModel.board[1][0], 8)
        XCTAssertEqual(viewModel.board[2][0], 16)
        XCTAssertEqual(viewModel.board[3][0], 32)
    }
    
    func test_can_push_numbers_to_up() {
        let engine = GameEngineStub()
        let viewModel = GameViewModel(engine)
        
        viewModel.push(.up)

        XCTAssertEqual(viewModel.board[0][0], 8)
        XCTAssertEqual(viewModel.board[0][1], 2)
        XCTAssertEqual(viewModel.board[0][2], 4)
        XCTAssertEqual(viewModel.board[0][3], 2)
        
        XCTAssertEqual(viewModel.board[1][0], 16)
        XCTAssertEqual(viewModel.board[1][1], 4)
        XCTAssertEqual(viewModel.board[1][2], 16)
        XCTAssertEqual(viewModel.board[1][3], 8)
    }
    
    func test_can_push_numbers_down() {
        let engine = GameEngineStub()
        let viewModel = GameViewModel(engine)
        
        viewModel.push(.down)

        XCTAssertEqual(viewModel.board[2][0], 8)
        XCTAssertEqual(viewModel.board[2][1], 2)
        XCTAssertEqual(viewModel.board[2][2], 4)
        XCTAssertEqual(viewModel.board[2][3], 2)
        
        XCTAssertEqual(viewModel.board[3][0], 16)
        XCTAssertEqual(viewModel.board[3][1], 4)
        XCTAssertEqual(viewModel.board[3][2], 16)
        XCTAssertEqual(viewModel.board[3][3], 8)
    }
    
    func test_can_tell_if_the_game_is_over() {
        let engine = GameEngineStub()
        let viewModel = GameViewModelStub(engine)
        viewModel.setGameOver()
        
        XCTAssertTrue(viewModel.engine.isGameOver(viewModel.board))
    }
    
    func test_can_score() {
        let engine = GameEngineStub()
        let viewModel = GameViewModelStub(engine)
        viewModel.setCanScoreRight()
        
        viewModel.push(.right)
        
        XCTAssertEqual(viewModel.score, 4)
    }
    
    func test_can_save_best_score() {
        let engine = GameEngineStub()
        let viewModel = GameViewModelStub(engine)
        viewModel.setCanScoreRight()
        
        viewModel.push(.right)
        viewModel.reset()
        
        XCTAssertEqual(viewModel.score, 0)
        XCTAssertEqual(viewModel.bestScore, 4)
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
    
    func setCanScoreRight() {
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
    
    func addNumber(_ board: [[Int]]) -> [[Int]] {
        GameEngine().addNumber(board)
    }
    
    func push(_ board: Matrix, to direction: Direction, scored: ((Int) -> Void)?) -> Matrix {
        GameEngine().push(board, to: direction, scored: scored)
    }
    
    let blankBoard: [[Int]] = [
        [0,2,0,2],
        [0,4,4,0],
        [8,0,0,8],
        [16,0,16,0]
    ]
}
