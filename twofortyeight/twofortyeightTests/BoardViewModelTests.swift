import XCTest
import SwiftUI
@testable import twofortyeight

class BoardViewModelTests: XCTestCase {
    
    func test_can_create_viewmodel() {
        let engine = GameEngine()
        let viewModel = BoardViewModel(engine)
        
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel.engine)
        XCTAssertEqual(viewModel.board, engine.blankBoard)
    }
    
    func test_can_reset_board() {
        let engine = GameEngineStub()
        let viewModel = BoardViewModel(engine)
        
        viewModel.reset()
        
        XCTAssertEqual(viewModel.board, engine.blankBoard)
    }
    
    func test_can_add_number_to_board() {
        let engine = GameEngine()
        let viewModel = BoardViewModel(engine)
        
        viewModel.addNumber()
        
        let hasNumber = viewModel.board.flatMap{ $0 }.reduce(0, +) != 0
        XCTAssertTrue(hasNumber)
    }
    
    func test_can_push_numbers_to_right() {
        let engine = GameEngineStub()
        let viewModel = BoardViewModel(engine)
        
        viewModel.push(.right)
        
        XCTAssertEqual(viewModel.board, [
            [0,0,0,4],
            [0,0,0,8],
            [0,0,0,16],
            [0,0,0,32]
        ])
    }
    
    func test_can_push_numbers_to_left() {
        let engine = GameEngineStub()
        let viewModel = BoardViewModel(engine)
        
        viewModel.push(.left)
        
        XCTAssertEqual(viewModel.board, [
            [4,0,0,0],
            [8,0,0,0],
            [16,0,0,0],
            [32,0,0,0]
        ])
    }
    
    func test_can_push_numbers_to_up() {
        let engine = GameEngineStub()
        let viewModel = BoardViewModel(engine)
        
        viewModel.push(.up)
        
        XCTAssertEqual(viewModel.board, [
            [8,2,4,2],
            [16,4,16,8],
            [0,0,0,0],
            [0,0,0,0]
        ])
    }
    
    func test_can_push_numbers_down() {
        let engine = GameEngineStub()
        let viewModel = BoardViewModel(engine)
        
        viewModel.push(.down)
        
        XCTAssertEqual(viewModel.board, [
            [0,0,0,0],
            [0,0,0,0],
            [8,2,4,2],
            [16,4,16,8]
        ])
    }
    
    func test_can_tell_if_the_game_is_over() {
        let engine = GameEngineStub()
        let viewModel = BoardViewModelStub(engine)
        viewModel.setGameOver()

        let isGameOver = viewModel.isGameOver()
        
        XCTAssertTrue(isGameOver)
    }
}

class BoardViewModelStub: BoardViewModel {
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
}

class GameEngineStub: Engine {
    func isGameOver(_ board: Matrix) -> Bool {
        GameEngine().isGameOver(board)
    }
    
    func addNumber(_ board: [[Int]]) -> [[Int]] {
        GameEngine().addNumber(board)
    }
    
    func push(_ board: [[Int]], to direction: Direction) -> [[Int]] {
        GameEngine().push(board, to: direction)
    }
    
    let blankBoard: [[Int]] = [
        [0,2,0,2],
        [0,4,4,0],
        [8,0,0,8],
        [16,0,16,0]
    ]
}
