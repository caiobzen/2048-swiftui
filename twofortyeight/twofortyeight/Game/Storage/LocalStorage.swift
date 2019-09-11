import Foundation

protocol Storage {
    func save(_ score: Int)
    var bestScore: Int { get }
}

class LocalStorage: Storage {
    private let bestScoreKey = "bestScore"
    
    var bestScore: Int {
        UserDefaults().integer(forKey: bestScoreKey)
    }

    func save(_ score: Int) {
        UserDefaults().set(score, forKey: bestScoreKey)
    }
}
