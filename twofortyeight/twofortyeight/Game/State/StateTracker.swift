//
//  StateTracker.swift
//  twofortyeight
//
//  Created by Igor on 17/03/2020.
//  Copyright © 2020 Carlos Corrêa. All rights reserved.
//

import Foundation

typealias GameState = (board: Matrix, score: Int)

protocol StateTracker {
    func next(with state: GameState) -> GameState
    func updateCurrent(with board: Matrix) -> GameState
    func reset(with state: GameState) -> GameState

    var isUndoable: Bool {get}
    func undo() -> GameState
    
    var statesCount: Int {get}
    var last: GameState {get}
}

