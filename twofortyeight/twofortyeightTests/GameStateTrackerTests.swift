//
//  GameStateTrackerTests.swift
//  twofortyeightTests
//
//  Created by Igor on 17/03/2020.
//  Copyright © 2020 Carlos Corrêa. All rights reserved.
//

import XCTest
@testable import twofortyeight

class GameStateTrackerTests: XCTestCase {
    
    private var stateTracker: GameStateTracker!
    
    private let initialState: GameState = ([
        [0,0,0,0],
        [0,0,0,0],
        [0,0,0,0],
        [0,0,0,0]
    ], 0)
    
    private let testState: GameState = ([
        [1,0,0,0],
        [0,0,0,0],
        [0,0,0,0],
        [0,0,0,0]
    ], 5)
    
    override func setUp() {
        stateTracker = GameStateTracker(initialState: initialState)
    }
    
    func test_has_1_state_after_init() {
        XCTAssertEqual(stateTracker.statesCount, 1)
    }
    
    func test_isUndoable_is_false_if_state_count_is_1() {
        XCTAssertFalse(stateTracker.isUndoable)
    }
    
    func test_can_add_state() {
        _ = stateTracker.next(with: testState)
        XCTAssertEqual(stateTracker.statesCount, 2)
    }
    
    func test_adding_state_returns_newly_added_state() {
        let result = stateTracker.next(with: testState)
        XCTAssertEqual(result.board, testState.board)
        XCTAssertEqual(result.score, testState.score)
    }
    
    func test_isUndoable_is_true_if_state_count_is_more_than_1() {
        _ = stateTracker.next(with: testState)
        XCTAssertTrue(stateTracker.isUndoable)
    }
    
    func test_last_returns_last_state() {
        XCTAssertEqual(stateTracker.last.board, initialState.board)
        XCTAssertEqual(stateTracker.last.score, initialState.score)
        _ = stateTracker.next(with: testState)
        XCTAssertEqual(stateTracker.last.board, testState.board)
        XCTAssertEqual(stateTracker.last.score, testState.score)
    }
    
    func test_can_reset() {
        let result = stateTracker.reset(with: testState)
        XCTAssertEqual(stateTracker.statesCount, 1)
        XCTAssertEqual(stateTracker.last.board, testState.board)
        XCTAssertEqual(stateTracker.last.score, testState.score)
        XCTAssertEqual(result.board, testState.board)
        XCTAssertEqual(result.score, testState.score)
    }
    
    func test_can_undo() {
        _ = stateTracker.next(with: testState)
        let result = stateTracker.undo()
        XCTAssertEqual(stateTracker.statesCount, 1)
        XCTAssertEqual(result.board, initialState.board)
        XCTAssertEqual(result.score, initialState.score)
        XCTAssertEqual(result.board, stateTracker.last.board)
        XCTAssertEqual(result.score, stateTracker.last.score)
    }
    
    func test_cannot_undo_if_states_count_is_1() {
        let result = stateTracker.undo()
        XCTAssertEqual(stateTracker.statesCount, 1)
        XCTAssertEqual(result.board, initialState.board)
        XCTAssertEqual(result.score, initialState.score)
    }
    
    func test_can_update_current() {
        let result = stateTracker.updateCurrent(with: testState.board)
        XCTAssertEqual(stateTracker.statesCount, 1)
        XCTAssertEqual(result.board, testState.board)
        XCTAssertEqual(result.score, initialState.score)
    }
    
}
