import UIKit

protocol PhoneTextFieldView: UIView {
    var didFieldChanged: (( _ data: PhoneTextFieldOutputData?) -> Void)? { get set }
    
    func update(status: PhoneTextFieldState, animated: Bool)
}
