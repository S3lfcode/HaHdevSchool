import UIKit

enum State {
    case info(text: String)
    case seconds(num: Int)
}

protocol VerificationView: UIView{
    func updateState(state: State)
}
