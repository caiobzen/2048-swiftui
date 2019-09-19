import Foundation

class GameEngine: Engine {
    let blankBoard = (1...4).map { _ in [0,0,0,0] }
    private var points = 0
    
    private var twoOrFour: Int {
        return Int.random(in: .zero...10) < 9 ? 2 : 4
    }
    
    func isGameOver(_ board: Matrix) -> Bool {
        !board.canCombineValues
    }
    
    func addNumber(_ board: Matrix) -> (newBoard: Matrix, addedTile: (Int, Int)?) {
        let emptyTile = board.randomIndex(for: .zero)
        var newBoard = board
        
        if let emptyTile = emptyTile {
            newBoard[emptyTile.row, emptyTile.column] = twoOrFour
        }
        
        return (newBoard, emptyTile)
    }
    
    func slide(_ row: [Int]) -> [Int] {
        let tilesWithNumbers = row.filter { $0 > .zero }
        let emptyTiles = row.count - tilesWithNumbers.count
        let arrayOfZeros = Array(repeating: Int.zero, count: emptyTiles)
        return arrayOfZeros + tilesWithNumbers
    }
    
    func combine(_ row: [Int]) -> [Int] {
        var newRow = row
        for column in (1...row.count - 1).reversed() {
            let prevColumn = column - 1
            let left = newRow[column]
            let right = newRow[prevColumn]
            if left == right {
                newRow[column] = left + right
                newRow[prevColumn] = .zero
                points += left + right
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
                newBoard[row][column] = board[column][row]
            }
        }
        return newBoard
    }
    
    private func operateRows(_ board: Matrix) -> Matrix {
        board.map(slideAndCombine)
    }
    
    func push(_ board: Matrix, to direction: Direction) -> (newBoard: Matrix, scoredPoints: Int) {
        var newBoard = board
        points = .zero
        
        switch direction {
        case .right: newBoard = (board |> pushRight)
        case .up:    newBoard = (board |> pushUp)
        case .left:  newBoard = (board |> pushLeft)
        case .down:  newBoard = (board |> pushDown)
        }
        
        return (newBoard, points)
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
