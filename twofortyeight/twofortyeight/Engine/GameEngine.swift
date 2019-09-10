import Foundation

enum Direction {
    case right
    case up
    case left
    case down
}

class GameEngine {
    let blankBoard = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    
    func addNumber(to board: [[Int]]) -> [[Int]] {
        var newBoard = board
        var options: [(Int, Int)] = []

        for i in 0..<newBoard.count {
            for j in 0..<newBoard[i].count {
                if newBoard[i][j] == 0 {
                    options.append((i,j))
                }
            }
        }
    
        if let spot = options.randomElement() {
            newBoard[spot.0][spot.1] = arc4random_uniform(2) > 0 ? 2 : 4
        }

        return newBoard
    }

    func slide(_ row: [Int]) -> [Int] {
        let arr = row.filter { $0 > 0 }
        let missing = row.count - arr.count
        var zeros = Array(repeating: 0, count: missing)
        zeros.append(contentsOf: arr)
        return zeros
    }

    func combine(_ row: [Int]) -> [Int] {
        var newRow = row
        for i in (1...row.count - 1).reversed() {
            let a = newRow[i]
            let b = newRow[i - 1]
            if a == b {
                newRow[i] = a + b
                newRow[i - 1] = 0
            }
        }
        return newRow
    }

    func flip(_ board:[[Int]]) -> [[Int]] {
        var newBoard = board
        for i in 0...newBoard.count - 1 {
            newBoard[i] = newBoard[i].reversed()
        }
        return newBoard
    }

    func rotate(_ board: [[Int]]) -> [[Int]] {
        var newBoard = blankBoard
        for i in 0..<board.count {
            for j in 0..<board[i].count {
                newBoard[i][j] = board[j][i];
            }
        }
        return newBoard
    }

    func push(_ board: [[Int]], to direction: Direction) -> [[Int]] {
        switch direction {
        case .right:
            return board |> pushRight
        case .up:
            return board |> pushUp
        case .left:
            return board |> pushLeft
        case .down:
            return board |> pushDown
        }
    }

    private func operateRows(on board: [[Int]]) -> [[Int]] {
        var newBoard = board
        for i in 0..<board.count {
            newBoard[i] = slideAndCombine(newBoard[i])
        }
        return newBoard
    }
    
    private func slideAndCombine(_ row: [Int]) -> [Int] {
        row
        |> slide
        |> combine
        |> slide
    }

    private func pushUp(_ board: [[Int]]) -> [[Int]] {
        board
        |> flip
        |> rotate
        |> operateRows
        |> flip
        |> rotate
        |> flip
    }

    private func pushDown(_ board: [[Int]]) -> [[Int]] {
        board
        |> rotate
        |> operateRows
        |> rotate
    }

    private func pushLeft(_ board: [[Int]]) -> [[Int]] {
        board
        |> flip
        |> operateRows
        |> flip
    }

    private func pushRight(_ board: [[Int]]) -> [[Int]] {
        board
        |> operateRows
    }
}

precedencegroup ForwardApplication {
    associativity: left
}

infix operator |>: ForwardApplication

public func |> <A,B>(x: A, f:(A) -> B) -> B {
    return f(x)
}
