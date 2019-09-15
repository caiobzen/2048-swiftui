import XCTest
@testable import twofortyeight

class LocalStorageTests: XCTestCase {
    private var storage: LocalStorage!
    
    override func setUp() {
        storage = LocalStorage()
        storage.reset()
    }
    
    func test_can_reset_data() {
        storage.save(score: 10)
        storage.save(bestScore: 99)
        storage.save(board: [[1,2,3,4]])
        
        storage.reset()
        
        XCTAssertEqual(storage.board, [[]])
        XCTAssertEqual(storage.score, 0)
        XCTAssertEqual(storage.bestScore, 0)
    }
    
    func test_can_save_score() {
        storage.save(score: 10)
        
        XCTAssertEqual(storage.score, 10)
    }
    
    func test_can_save_best_score() {
        storage.save(bestScore: 99)
        
        XCTAssertEqual(storage.bestScore, 99)
    }
    
    func test_can_save_board() {
        storage.save(board: [
            [1,2,3,4],
            [1,2,3,4],
            [1,2,3,4],
            [1,2,3,4]
        ])
        
        XCTAssertEqual(storage.board, [
            [1,2,3,4],
            [1,2,3,4],
            [1,2,3,4],
            [1,2,3,4]
        ])
    }
}
