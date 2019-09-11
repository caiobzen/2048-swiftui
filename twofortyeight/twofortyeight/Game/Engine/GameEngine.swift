import Foundation

typealias Matrix = [[Int]]

protocol Engine {
    func addNumber(_ board: Matrix) -> Matrix
    func push(_ board: Matrix, to direction: Direction, scored:((Int) -> Void)?) -> Matrix
    func isGameOver(_ board: Matrix) -> Bool
    var blankBoard: Matrix { get }
}

enum Direction {
    case right
    case up
    case left
    case down
}

class GameEngine: Engine {
    let blankBoard = Array(repeating: [0,0,0,0], count: 4)
    var points = 0
        
    func isGameOver(_ board: Matrix) -> Bool {
        board.canCombineValues == false
    }
    
    private var zeroOrTwo: Int {
        arc4random_uniform(2) > 0 ? 2 : 4
    }

    func addNumber(_ board: Matrix) -> Matrix {
        var newBoard = board

        if let spot = board.randomIndex(for: 0) {
            newBoard[spot.0, spot.1] = zeroOrTwo
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
        for column in (1...row.count - 1).reversed() {
            let a = newRow[column]
            let b = newRow[column - 1]
            if a == b {
                newRow[column] = a + b
                newRow[column - 1] = 0
                points += a + b
            }
        }
        return newRow
    }

    func flip(_ board: Matrix) -> Matrix {
        var newBoard = board
        for row in 0...newBoard.count - 1 {
            newBoard[row] = newBoard[row].reversed()
        }
        return newBoard
    }

    func rotate(_ board: Matrix) -> Matrix {
        var newBoard = blankBoard
        for row in 0..<board.count {
            for column in 0..<board[row].count {
                newBoard[row][column] = board[column][row];
            }
        }
        return newBoard
    }

    func push(_ board: Matrix, to direction: Direction, scored:((Int) -> Void)? = nil) -> Matrix {
        var newBoard = board
        points = 0
        
        switch direction {
        case .right:
            newBoard = (board |> pushRight)
        case .up:
            newBoard = (board |> pushUp)
        case .left:
            newBoard = (board |> pushLeft)
        case .down:
            newBoard = (board |> pushDown)
        }
        
        scored?(points)
        return newBoard
    }

    private func operateRows(_ board: Matrix) -> Matrix {
        var newBoard = board
        for row in 0..<board.count {
            newBoard[row] = slideAndCombine(newBoard[row])
        }
        return newBoard
    }
    
    private func slideAndCombine(_ row: [Int]) -> [Int] {
        row
        |> slide
        |> combine
        |> slide
    }

    private func pushUp(_ board: Matrix) -> Matrix {
        board
        |> rotate
        |> flip
        |> operateRows
        |> flip
        |> rotate
    }

    private func pushDown(_ board: Matrix) -> Matrix {
        board
        |> rotate
        |> operateRows
        |> rotate
    }

    private func pushLeft(_ board: Matrix) -> Matrix {
        board
        |> flip
        |> operateRows
        |> flip
    }

    private func pushRight(_ board: Matrix) -> Matrix {
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

extension Array {
    func toMatrix() {
        for row in 0..<count {
            print("[\(self[row])]")
        }
    }
}
