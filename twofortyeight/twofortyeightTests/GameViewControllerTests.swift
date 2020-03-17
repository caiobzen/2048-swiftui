import XCTest
import SwiftUI
@testable import twofortyeight

class GameViewControllerTests: XCTestCase {
    func test_view_controller_call_start_on_init() {
        let viewModel = GameViewModelSpy(GameEngineStub(), storage: MockStorage(), stateTracker: GameStateTrackerStub())
        
        let _ = GameViewController(viewModel: viewModel)
        
        XCTAssertTrue(viewModel.didCallStart)
    }
}

private class GameViewModelSpy: GameViewModel {
    var didCallStart = false
    
    override func start() {
        didCallStart.toggle()
    }
}
