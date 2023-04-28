import Foundation

final class PhoneTextFieldVC <View: PhoneTextFieldView>: BaseViewController<View> {
    var phoneNum: ((_ phone: String) -> Void)?
    
    override func viewDidLoad() {
        rootView.currentNumber = phoneNum
    }
}
