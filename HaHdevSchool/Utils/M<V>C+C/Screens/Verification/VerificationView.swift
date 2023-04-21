import UIKit

enum State {
    case info(text: String)
    case timer(num: Int)
}

protocol VerificationView: UIView{
    func updateState(state: State)
}
