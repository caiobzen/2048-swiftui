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
    
    func test_starts_with_zero_score() {
        _ = robot
            .assertScoreIs(0)
    }
    
    func test_can_score() {
        _ = robot
            .swipeLeft()
            .swipeRight()
            .swipeUp()
            .swipeDown()
            .swipeLeft()
            .swipeRight()
            .swipeUp()
            .swipeDown()
            .assertScoreIsGreaterThan(0)
    }
}
