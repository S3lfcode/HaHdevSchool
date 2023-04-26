import Foundation

final class PhoneTextFieldController <View: PhoneTextFieldView>: BaseViewController<View> {
    var phoneNum: ((_ phone: String) -> Void)?
    
    override func viewDidLoad() {
        rootView.currentNumber = phoneNum
    }
}
