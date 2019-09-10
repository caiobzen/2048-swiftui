import Foundation

typealias Matrix = [[Int]]

protocol Engine {
    func addNumber(_ board: Matrix) -> Matrix
    func push(_ board: Matrix, to direction: Direction) -> Matrix
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
    let blankBoard = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    
    func isGameOver(_ board: Matrix) -> Bool {
        var isOver = true
        for  i in 0..<board.count {
            for j in 0..<board[i].count {
                if board[i][j] == 0 {
                    isOver = false
                    break
                }
                
                let canCombineRow = i != board.count - 1 && board[i][j] == board[i + 1][j]
                let canCombineColumn = j != board.count - 1 && board[i][j] == board[i][j + 1]
                if canCombineRow || canCombineColumn {
                    isOver = false
                    break
                }
            }
        }
        return isOver
    }
    
    func addNumber(_ board: Matrix) -> Matrix {
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

    func flip(_ board: Matrix) -> Matrix {
        var newBoard = board
        for i in 0...newBoard.count - 1 {
            newBoard[i] = newBoard[i].reversed()
        }
        return newBoard
    }

    func rotate(_ board: Matrix) -> Matrix {
        var newBoard = blankBoard
        for i in 0..<board.count {
            for j in 0..<board[i].count {
                newBoard[i][j] = board[j][i];
            }
        }
        return newBoard
    }

    func push(_ board: Matrix, to direction: Direction) -> Matrix {
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

    private func operateRows(_ board: Matrix) -> Matrix {
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
        for i in 0..<count {
            print("[\(self[i])]")
        }
    }
}
