import Foundation

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
}
