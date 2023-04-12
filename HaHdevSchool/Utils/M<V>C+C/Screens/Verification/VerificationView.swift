import UIKit

protocol VerificationView: UIView, ApplicationGroundViewInput{
    func updateState(text: String)
}
