import Foundation

class LocalStorage: Storage {
    private let scoreKey = "score"
    private let bestScoreKey = "bestScore"
    private let boardKey = "onGoingGame"
    
    func reset() {
        save(score: 0)
        save(bestScore: 0)
        save(board: [[]])
    }
    
    var score: Int {
        UserDefaults().integer(forKey: scoreKey)
    }

    var bestScore: Int {
        UserDefaults().integer(forKey: bestScoreKey)
    }

    var board: [[Int]]? {
        UserDefaults().object(forKey: boardKey) as? [[Int]]
    }
    
    func save(score: Int) {
        UserDefaults().set(score, forKey: scoreKey)
    }
    
    func save(bestScore: Int) {
        UserDefaults().set(bestScore, forKey: bestScoreKey)
    }

    func save(board: [[Int]]) {
        UserDefaults().set(board, forKey: boardKey)
    }
}
