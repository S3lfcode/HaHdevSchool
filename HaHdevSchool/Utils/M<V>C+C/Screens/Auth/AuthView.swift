import UIKit

protocol AuthView: UIView, KeyboardableViewInput {
    var onVerificationAction: (() -> Void)? { get set }

    func displayLoading(enable: Bool)
}
