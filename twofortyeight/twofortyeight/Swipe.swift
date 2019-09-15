import UIKit

class Swipe: UISwipeGestureRecognizer {
    private var target: InvokeTarget

    init(_ direction: Direction, action: @escaping () -> ()) {
        self.target = InvokeTarget(action: action)
        super.init(target: target, action: #selector(target.invoke))
        self.direction = direction
    }
}

class InvokeTarget: NSObject {
    private var action: () -> ()

    init(action: @escaping () -> ()) {
        self.action = action
        super.init()
    }

    @objc public func invoke() {
        self.action()
    }
}
