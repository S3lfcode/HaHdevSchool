import Foundation

struct PhoneTextFieldOutputData {
    
    let text: String?
    let error: PhoneTextFieldError?
    
}

protocol PhoneTextFieldOutput {
    
    func display(error: PhoneTextFieldError?)
    
}
