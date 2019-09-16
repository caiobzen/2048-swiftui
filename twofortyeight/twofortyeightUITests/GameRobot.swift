import XCTest

struct GameRobot {
    let app = XCUIApplication()
    
    private var menuButton: XCUIElement? {
        app.buttons["menuButton"]
    }
    
    private var newGameButton: XCUIElement? {
        app.buttons["newGameButton"]
    }
    
    private var resetBestScoreButton: XCUIElement? {
        app.buttons["resetBestScoreButton"]
    }
    
    func swipeLeft() -> Self {
        app.swipeLeft()
        return self
    }
    
    func swipeRight() -> Self {
        app.swipeRight()
        return self
    }
    
    func swipeUp() -> Self {
        app.swipeUp()
        return self
    }
    func swipeDown() -> Self {
        app.swipeLeft()
        return self
    }
    
    func assertExists(_ text: String) {
        XCTAssertTrue(app.staticTexts[text].exists)
    }
    
    func assertScoreIs(_ score: Int) {
        XCTAssertEqual(app.staticTexts["scoreValue"].label, "\(score)")
    }
    
    func assertScoreIsGreaterThan(_ score: Int) {
        let scoreValue = Int(app.staticTexts["scoreValue"].label) ?? 0
        XCTAssertTrue(scoreValue > score)
    }
    
    func assertHasTile() {
        let containsTwo = NSPredicate(format: "label == %@", "2")
        let containsFour = NSPredicate(format: "label == %@", "4")

        let twoTiles = app.staticTexts.containing(containsTwo)
        let fourTiles = app.staticTexts.containing(containsFour)
        
        let allTiles = twoTiles.allElementsBoundByIndex + fourTiles.allElementsBoundByIndex
        XCTAssertFalse(allTiles.isEmpty)
    }
    
    func tapMenu() -> Self {
        menuButton?.tap()
        return self
    }
    
    func tapNewGame() -> Self {
        newGameButton?.tap()
        return self
    }
    
    func tapResetBestScore() -> Self {
        resetBestScoreButton?.tap()
        return self
    }
}
