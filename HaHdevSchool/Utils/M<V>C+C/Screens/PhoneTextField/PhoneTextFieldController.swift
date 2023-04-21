import Foundation

final class PhoneTextFieldController <View: PhoneTextFieldViewImp>: BaseViewController<View> {
    var phoneSearch: ((_ phone: String, _ completion: @escaping () -> Void) -> Void)?
    
    override func viewDidLoad() {
        rootView.phoneSearch = phoneSearch
    }
}
