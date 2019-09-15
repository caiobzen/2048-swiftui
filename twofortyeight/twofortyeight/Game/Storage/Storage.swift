import Foundation

protocol Storage {
    var board: [[Int]]? { get }
    var score: Int { get }
    var bestScore: Int { get }
    
    func save(score: Int)
    func save(bestScore: Int)
    func save(board: [[Int]])
}
