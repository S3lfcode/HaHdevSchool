import Foundation

enum PhoneTextFieldError: Swift.Error {
    case invalidFormat
    case emptyField
    case null
    
    var description: String {
        switch self {
        case .invalidFormat:
            return "Неверный формат номера"
        case .emptyField:
            return "Поле не может быть пустым"
        case .null:
            return "Значение не может быть null"
        }
    }
}
