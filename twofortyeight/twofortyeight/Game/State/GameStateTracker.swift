//
//  GameStateTracker.swift
//  twofortyeight
//
//  Created by Igor on 17/03/2020.
//  Copyright © 2020 Carlos Corrêa. All rights reserved.
//

import Foundation

class GameStateTracker: StateTracker {
    
    private var states: [GameState]
    var last: GameState {
        return states.last!
    }
    
    var statesCount: Int {
        return states.count
    }
    
    init(initialState: GameState) {
        self.states = [initialState]
    }
    
    var isUndoable: Bool {
        return states.count > 1
    }
    
    func next(with state: GameState) -> GameState {
        states.append(state)
        return last
    }
  
    func updateCurrent(with board: Matrix) -> GameState {
        let current = last
        let new = (board, current.score)
        states[states.count - 1] = new
        return last
    }
    
    func undo() -> GameState {
        if isUndoable {
            _ = states.popLast()
        }
        return last
    }
    
    func reset(with state: GameState) -> GameState {
        states = [state]
        return last
    }
    
}
