protocol Storage {
    func save(_ score: Int)
    var bestScore: Int { get }
}
