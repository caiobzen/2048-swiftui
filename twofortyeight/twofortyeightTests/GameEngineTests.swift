import XCTest
@testable import twofortyeight

class GameEngineTests: XCTestCase {
    let engine = GameEngine()
    
    func test_can_create_engine() {
        XCTAssertNotNil(engine)
    }
    
    func test_can_add_number() {
        let board = [[0,0,0,0],
                     [0,0,0,0],
                     [0,0,0,0],
                     [0,0,0,0]]
        
        let newBoard = engine.addNumber(to: board)
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
    
    func test_can_rotate_board() {
        let board = [
            [2,0,2,0],
            [0,0,0,4],
            [0,8,8,0],
            [0,16,0,16]
        ]
        
        let newRow = engine.rotate(board)
        
        XCTAssertEqual(newRow, [
             [2,0,0,0],
             [0,0,8,16],
             [2,0,8,0],
             [0,4,0,16]
         ])
    }
    
    func test_shift_right() {
        let board = [
            [2,0,2,0],
            [0,4,0,4],
            [0,8,8,0],
            [0,16,0,16]
        ]
        
        let newBoard = engine.push(board, to: .right)
        
        XCTAssertEqual(newBoard, [
            [0,0,0,4],
            [0,0,0,8],
            [0,0,0,16],
            [0,0,0,32]
        ])
    }
}
