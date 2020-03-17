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
    
    private var undoButton: XCUIElement? {
        app.buttons["undoButton"]
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
    
    func tapMenu() -> Self {
        menuButton?.tap()
        return self
    }
    
    @discardableResult
    func tapNewGame() -> Self {
        newGameButton?.tap()
        return self
    }
    
    func tapResetBestScore() -> Self {
        resetBestScoreButton?.tap()
        return self
    }
  
    func tapUndo() -> Self {
        undoButton?.tap()
        return self
    }
    
    @discardableResult
    func assertExists(_ text: String) -> Self {
        XCTAssertTrue(app.staticTexts[text].exists)
        return self
    }
    
    @discardableResult
    func assertScoreIs(_ score: Int) -> Self {
        XCTAssertEqual(app.staticTexts["scoreValue"].label, "\(score)")
        return self
    }
    
    @discardableResult
    func assertScoreIsGreaterThan(_ score: Int) -> Self {
        let scoreValue = Int(app.staticTexts["scoreValue"].label) ?? 0
        XCTAssertTrue(scoreValue > score)
        return self
    }
    
    @discardableResult
    func assertHasTile() -> Self {
        let containsTwo = NSPredicate(format: "label == %@", "2")
        let containsFour = NSPredicate(format: "label == %@", "4")

        let twoTiles = app.staticTexts.containing(containsTwo)
        let fourTiles = app.staticTexts.containing(containsFour)
        
        let allTiles = twoTiles.allElementsBoundByIndex + fourTiles.allElementsBoundByIndex
        XCTAssertFalse(allTiles.isEmpty)
        
        return self
    }
}
