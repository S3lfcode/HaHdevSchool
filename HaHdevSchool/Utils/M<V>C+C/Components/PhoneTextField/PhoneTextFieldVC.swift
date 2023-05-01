import Foundation

final class PhoneTextFieldVC <View: PhoneTextFieldView>: BaseViewController<View> {
    
    var didFieldChanged: (( _ data: PhoneTextFieldOutputData?) -> Void)?
    
    override func viewDidLoad() {
        rootView.didFieldChanged = didFieldChanged
    }
}

extension PhoneTextFieldVC: PhoneTextFieldOutput {
    
    func display(error: PhoneTextFieldError? ) {
        guard let error = error else {
            return
        }
        
        rootView.update(
            status: .error(message: error.description),
            animated: true)
    }
    
}
