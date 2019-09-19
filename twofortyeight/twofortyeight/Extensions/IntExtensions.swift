import Foundation

extension Int {
    var digits: Int {
        String(self).count
    }
    
    mutating func increase() {
        self += 1
    }
}
