typealias Matrix = [[Int]]

enum Direction {
    case right
    case up
    case left
    case down
}

protocol Engine {
    func addNumber(_ board: Matrix) -> (newBoard: Matrix, addedTile: (Int, Int)?)
    func push(_ board: Matrix, to direction: Direction, scored:((Int) -> Void)?) -> Matrix
    func isGameOver(_ board: Matrix) -> Bool
    var blankBoard: Matrix { get }
}
