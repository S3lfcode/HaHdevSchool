import UIKit

enum VerificationState {
    case info(text: String)
    case timer(num: Int)
}

protocol VerificationView: UIView{
    func updateState(state: VerificationState)
    func configureNavController(navItem: UINavigationItem)
    
    var onBack: (() -> Void)? { get set }
}
