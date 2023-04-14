import UIKit

protocol AuthView: UIView, KeyboardableViewInput {
    var onVerificationAction: ((_ phone: String?) -> Void)? { get set }
    
    func updateStatus(error: String, animated: Bool)
    func displayLoading(enable: Bool)
}
