import Foundation

struct PhoneTextFieldContext {

    let didFieldChanged: ( _ data: PhoneTextFieldOutputData?) -> Void
    
    let errorProvider: (_ provider: PhoneTextFieldOutput) -> Void
    
}
