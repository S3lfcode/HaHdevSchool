import UIKit

public protocol KeyboardableViewInput: AnyObject {
    func connectKeyboard()
    func disconnectKeyboard()
}

public protocol KeybordableView: KeyboardableViewInput {
    var keyboardToken: Any? {get set}
    
    func apply(keyboardHeight: CGFloat, keyboardWillShow: Bool)
}

extension KeybordableView where Self: UIView {
    func connectKeyboard() {
        keyboardToken = [
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillShowNotification,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                self?.update(with: notification, willShow: true)
            },
            
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                self?.update(with: notification, willShow: false)
            }
        ]
    }
    
    func disconnectKeyboard() {
        keyboardToken = nil
    }
    
    private func update(with notification: Notification, willShow: Bool) {
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        
        guard let userInfo = notification.userInfo,
              let duration = (userInfo[durationKey] as? NSNumber)?.doubleValue,
              let curveValue = (userInfo[curveKey] as? NSNumber)?.intValue,
              let curve = UIView.AnimationCurve(rawValue: curveValue),
              let size = (userInfo[frameKey] as? NSValue)?.cgRectValue
        else { return }
        
        UIViewPropertyAnimator(duration: duration, curve: curve) { [weak self] in
            guard let self = self else { return }
            self.apply(keyboardHeight: size.height, keyboardWillShow: willShow)
        }.startAnimation()
        
    }
}
