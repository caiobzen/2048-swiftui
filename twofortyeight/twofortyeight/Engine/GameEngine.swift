import Foundation

enum Direction {
    case right
    case up
    case left
    case down
}

class GameEngine {
    func addNumber(to board: [[Int]]) -> [[Int]] {
        var newBoard = board
        var options: [(Int, Int)] = []
        
        for i in 0..<board.count {
            for j in 0..<board[i].count {
                if board[i][j] == 0 {
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
        for i in 0...board.count - 1 {
            newBoard[i] = newBoard[i].reversed()
        }
        return newBoard
    }
    
    func rotate(_ board: [[Int]]) -> [[Int]] {
        var newBoard = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
        for i in 0..<board.count {
            for j in 0..<board[i].count {
                newBoard[i][j] = board[j][i];
            }
        }
        return newBoard
    }
    
    func push(_ board: [[Int]], to direction: Direction) -> [[Int]] {
        var newBoard = board
        var rotated = false
        var flipped = false
        
        switch direction {
        case .right:
            rotated.toggle()
            newBoard = rotate(board)
        case .up: print("do nothing")
        case .left:
            newBoard = rotate(newBoard)
            newBoard = flip(newBoard)
            rotated.toggle()
            flipped.toggle()
        case .down: print("do nothing") }
        
        for i in 0..<board.count {
            newBoard[i] = operate(board[i])
        }
        
        if (flipped) {
          newBoard = flip(newBoard)
        }
        
        if (rotated) {
            for _ in 1...board.count {
                 newBoard = rotate(newBoard)
            }
        }
        
        return newBoard
    }
    
    private func operate(_ row: [Int]) -> [Int] {
        var newRow = row
        newRow = slide(newRow)
        newRow = combine(newRow)
        newRow = slide(newRow)
        return newRow
    }
}
