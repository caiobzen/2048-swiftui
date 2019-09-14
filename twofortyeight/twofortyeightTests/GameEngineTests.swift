import XCTest
@testable import twofortyeight

class GameEngineTests: XCTestCase {
    let engine = GameEngine()
    
    private let horizontalScoreBoard = [
        [2,0,2,0],
        [0,4,0,4],
        [0,8,8,0],
        [0,16,0,16]
    ]
    
    private let verticalScoreBoard = [
        [2,0,0,0],
        [2,4,0,0],
        [0,4,8,16],
        [0,0,8,16]
    ]
    
    func test_can_create_engine() {
        XCTAssertNotNil(engine)
    }
    
    func test_can_add_number() {
        let board = Array(repeating: [0,0,0,0], count: 4)
        
        let newBoard = engine.addNumber(board).newBoard
        let hasNumber = newBoard.flatMap{ $0 }.reduce(0, +) != 0
        
        XCTAssertTrue(hasNumber)
    }
    
    func test_can_slide_row_to_right() {
        let row = [0,2,4,0]
        
        let newRow = engine.slide(row)
        
        XCTAssertEqual(newRow, [0,0,2,4])
    }
    
    func test_can_combine_numbers_to_right() {
        let row = [0,0,2,2]
        
        let newRow = engine.combine(row)
        
        XCTAssertEqual(newRow, [0,0,0,4])
    }
    
    func test_can_flip_board() {
        let newRow = engine.flip(horizontalScoreBoard)
        
        XCTAssertEqual(newRow, [
            [0,2,0,2],
            [4,0,4,0],
            [0,8,8,0],
            [16,0,16,0]
        ])
    }
    
    func test_can_rotate_board() {
        let newRow = engine.rotate(horizontalScoreBoard)
        
        XCTAssertEqual(newRow, [
             [2,0,0,0],
             [0,4,8,16],
             [2,0,8,0],
             [0,4,0,16]
         ])
    }
    
    func test_push_right() {
        let result = engine.push(horizontalScoreBoard, to: .right)
        
        XCTAssertEqual(result.newBoard, [
            [0,0,0,4],
            [0,0,0,8],
            [0,0,0,16],
            [0,0,0,32]
        ])
    }
    
    func test_push_left() {
        let result = engine.push(horizontalScoreBoard, to: .left)
        
        XCTAssertEqual(result.newBoard, [
            [4,0,0,0],
            [8,0,0,0],
            [16,0,0,0],
            [32,0,0,0]
        ])
    }
    
    func test_push_up() {
        let result = engine.push(verticalScoreBoard, to: .up)
        
        XCTAssertEqual(result.newBoard, [
            [4,8,16,32],
            [0,0,0,0],
            [0,0,0,0],
            [0,0,0,0]
        ])
    }
    
    func test_push_down() {
        let result = engine.push(verticalScoreBoard, to: .down)
        
        XCTAssertEqual(result.newBoard, [
            [0,0,0,0],
            [0,0,0,0],
            [0,0,0,0],
            [4,8,16,32]
        ])
    }
    
    func test_is_game_over() {
        let board = [
            [2,16,2,16],
            [4,8,4,8],
            [8,4,8,4],
            [16,2,16,2]
        ]
                
        XCTAssertTrue(engine.isGameOver(board))
    }
    
    func test_can_compare_boards() {
        let board = [
            [0,0,2,0],
            [0,0,2,0],
            [0,0,2,0],
            [0,0,2,0]
        ]
        
        let newBoard = engine.rotate(board)
        
        XCTAssertFalse(newBoard.isEqual(board))
    }
}
