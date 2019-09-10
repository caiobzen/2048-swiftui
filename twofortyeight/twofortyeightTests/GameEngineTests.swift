import XCTest
@testable import twofortyeight

class GameEngineTests: XCTestCase {
    func test_can_create_engine() {
        let engine = GameEngine()
        
        XCTAssertNotNil(engine)
    }
    
    func test_can_add_number() {
        let engine = GameEngine()
        let board = [[0,0,0,0],
                     [0,0,0,0],
                     [0,0,0,0],
                     [0,0,0,0]]
        
        let newBoard = engine.addNumber(to: board)
        let hasNumber = newBoard.flatMap{ $0 }.reduce(0, +) != 0
        
        XCTAssertTrue(hasNumber)
    }
    
    func test_can_slide_row_to_right() {
        let engine = GameEngine()
        let row = [0,2,4,0]
        
        let newRow = engine.slide(row)
        
        XCTAssertEqual(newRow, [0,0,2,4])
    }
    
    func test_can_combine_numbers_to_right() {
        let engine = GameEngine()
        let row = [0,0,2,2]
        
        let newRow = engine.combine(row)
        
        XCTAssertEqual(newRow, [0,0,0,4])
    }
    
    func test_can_flip_board() {
        let engine = GameEngine()
        let board = [
            [2,0,2,0],
            [0,0,0,4],
            [0,8,8,0],
            [0,16,0,16]
        ]
        
        let newRow = engine.flip(board)
        
        XCTAssertEqual(newRow, [
            [0,2,0,2],
            [4,0,0,0],
            [0,8,8,0],
            [16,0,16,0]
        ])
    }
}
