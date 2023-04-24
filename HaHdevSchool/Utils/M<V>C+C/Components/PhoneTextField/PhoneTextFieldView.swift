import Foundation

protocol PhoneTextFieldView {
    var phoneSearch: ((_ phone: String, _ completion: @escaping () -> Void) -> Void)? { get set }
}
