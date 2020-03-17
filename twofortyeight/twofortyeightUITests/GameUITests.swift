import XCTest

class GameUITests: XCTestCase {
    let app = XCUIApplication()
    let robot = GameRobot()
    
    override func setUp() {
        app.launch()
        robot
        .tapMenu()
        .tapNewGame()
    }
    
    func test_board_starts_with_a_tile() {
        robot
        .assertHasTile()
    }
    
    func test_can_swipe_board() {
        robot
        .tapMenu()
        .assertExists("MENU")
    }
    
    func test_starts_with_zero_score() {
        robot
        .assertScoreIs(0)
    }
    
    func test_can_score() {
        robot
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
    
    func test_can_undo() {
        robot
        .swipeLeft()
        .swipeRight()
        .swipeUp()
        .swipeDown()
        .swipeLeft()
        .swipeRight()
        .swipeUp()
        .swipeDown()
        .assertScoreIsGreaterThan(0)
        .tapUndo()
        .tapUndo()
        .tapUndo()
        .tapUndo()
        .tapUndo()
        .tapUndo()
        .tapUndo()
        .tapUndo()
        .assertScoreIs(0)
    }
    
    func test_when_scored_on_new_game_reset_score() {
        robot
        .swipeLeft()
        .swipeRight()
        .swipeUp()
        .swipeDown()
        .tapMenu()
        .tapNewGame()
        .assertScoreIs(0)
    }
}
