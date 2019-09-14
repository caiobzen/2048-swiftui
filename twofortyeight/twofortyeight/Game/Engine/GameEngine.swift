import Foundation

class GameEngine: Engine {
    let blankBoard = (1...4).map { _ in [0,0,0,0] }
    private var points = 0
    
    private var twoOrFour: Int {
        return Int.random(in: .zero...10) < 9 ? 2 : 4
    }
        
    func isGameOver(_ board: Matrix) -> Bool {
        board.canCombineValues == false
    }

    func addNumber(_ board: Matrix) -> (newBoard: Matrix, addedTile: (Int, Int)?) {
        var newBoard = board

        if let tileToBeAdded = board.randomIndex(for: .zero) {
            newBoard[tileToBeAdded.row, tileToBeAdded.column] = twoOrFour
            return (newBoard, tileToBeAdded)
        }

        return (newBoard, nil)
    }

    func slide(_ row: [Int]) -> [Int] {
        let tilesWithNumbers = row.filter { $0 > .zero }
        let missingNumbers = row.count - tilesWithNumbers.count
        var arrayOfZeros = Array(repeating: Int.zero, count: missingNumbers)
        arrayOfZeros.append(contentsOf: tilesWithNumbers)
        return arrayOfZeros
    }

    func combine(_ row: [Int]) -> [Int] {
        var newRow = row
        for column in (1...row.count - 1).reversed() {
            let a = newRow[column]
            let b = newRow[column - 1]
            if a == b {
                newRow[column] = a + b
                newRow[column - 1] = .zero
                points += a + b
            }
        }
        return newRow
    }

    func flip(_ board: Matrix) -> Matrix {
        board.map { $0.reversed() }
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
        points = .zero
        
        switch direction {
        case .right: newBoard = (board |> pushRight)
        case .up:    newBoard = (board |> pushUp)
        case .left:  newBoard = (board |> pushLeft)
        case .down:  newBoard = (board |> pushDown)
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
