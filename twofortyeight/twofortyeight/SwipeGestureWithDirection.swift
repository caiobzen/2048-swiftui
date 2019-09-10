import UIKit

class SwipeGestureWithDirection: UISwipeGestureRecognizer {
    private var invokeTarget: UIGestureRecognizerInvokeTarget

    init(_ direction: Direction, action: @escaping () -> ()) {
        self.invokeTarget = UIGestureRecognizerInvokeTarget(action: action)
        super.init(target: invokeTarget, action: #selector(invokeTarget.invoke))
        self.direction = direction
    }
}

class UIGestureRecognizerInvokeTarget: NSObject {
    private var action: () -> ()

    init(action: @escaping () -> ()) {
        self.action = action
        super.init()
    }

    @objc public func invoke() {
        self.action()
    }
}
