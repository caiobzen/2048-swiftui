import XCTest

class GameUITests: XCTestCase {
    var app: XCUIApplication!
    var robot = GameRobot()
    
    override func setUp() {
        XCUIApplication().launch()
        _ = robot
            .tapMenu()
            .tapNewGame()
    }
    
    func test_board_starts_with_a_tile() {
        _ = robot
            .assertHasTile()
    }
    
    func test_can_swipe_board() {
        _ = robot
            .tapMenu()
            .assertExists("menuLabel")
    }
}
