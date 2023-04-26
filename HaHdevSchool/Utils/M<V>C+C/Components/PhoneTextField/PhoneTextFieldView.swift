import UIKit

protocol PhoneTextFieldView: UIView {
    var currentNumber: ((_ phone: String) -> Void)? { get set }
}
