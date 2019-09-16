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
    
    func assertExists(_ text: String) {
        XCTAssertTrue(app.staticTexts[text].exists)
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
