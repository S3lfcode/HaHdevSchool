import Foundation
import UIKit

class MaterialTextField: UIView {
    
    enum State {
        case `default`
        case active
        case error(message: String)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textField)
        addSubview(placeholderLabel)
        addSubview(errorLabel)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "Colors/Phone/background")?.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.frame = textFieldFrame(state: state)
        placeholderLabel.frame = placeholderLabelFrame(state: state)
        errorLabel.frame = errorLabelFrame(state: state)
        
        if bounds.height != errorLabel.frame.maxY {
            invalidateIntrinsicContentSize()
        }
    }
    
    private enum Constants {
        static let textFieldHeight: CGFloat = 50
    }
    
    func textFieldFrame(state: State) -> CGRect {
        if textIsEditing {
            return .init(
                x: 16,
                y: 27,
                width: bounds.width-16,
                height: bounds.height-36
            )
        }
        
        return .init(
            x: 16,
            y: 0,
            width: bounds.width-16,
            height: bounds.height)
    }
    
    private var textIsEditing: Bool = false
    
    func placeholderLabelFrame(state: State) -> CGRect {
        let size = placeholderLabel.sizeThatFits(.init(width: bounds.height, height: 0))
        
        if textIsEditing {
            placeholderLabel.font = UIFont(name: "GothamSSm-Book", size: 12)
            return .init(
                x: 16,
                y: 9,
                width: bounds.width,
                height: size.height
            )
        }
        placeholderLabel.font = UIFont(name: "GothamSSm-Book", size: 14)
        return .init(
            x: 16,
            y: bounds.height/3,
            width: bounds.width,
            height: size.height
        )
        
    }
    
    func errorLabelFrame(state: State) -> CGRect {
        let size = errorLabel.sizeThatFits(.init(width: bounds.width, height: 0))
        
        return .init(
            x: 0,
            y: Constants.textFieldHeight+10,
            width: bounds.width,
            height: size.height
        )
    }
    
    private(set) var state: State = .default
    
    func update(state: State, animated: Bool) {
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.update(state: state)
            self.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func update(state: State) {
        self.state = state
        switch state {
        case .`default`:
            layer.borderColor = UIColor(named: "Colors/Phone/background")?.cgColor
            errorLabel.alpha = 0
            errorLabel.text = nil
        case .active:
            layer.borderColor = UIColor(named: "Colors/Primary/blue")?.cgColor
            errorLabel.alpha = 0
            errorLabel.text = nil
        case .error(let message):
            layer.borderColor = UIColor(named: "Colors/Primary/red")?.cgColor
            errorLabel.alpha = 1
            errorLabel.text = message
        }
        setNeedsLayout()
    }
    
    override var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: errorLabel.frame.maxY)
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "Colors/Phone/background")
        textField.font = UIFont(name: "GothamSSm-Book", size: 14)
        textField.delegate = self
        return textField
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Colors/Phone/placeholder")
        label.text = "Номер телефона"
        label.font = UIFont(name: "GothamSSm-Book", size: 14)
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "GothamSSm-Book", size: 14)
        label.textColor = .red
        return label
    }()
    
    
}

extension MaterialTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else {return}
        for char in text {
            if !char.isNumber && char != " " {
                update(state: .error(message: "Можно вводить только цифры"), animated: true)
                return
            }
        }
        update(state: .active, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        update(state: .default, animated: true)
    }
    
    private func phoneFormatter(mask: String, number: String) -> String {
        let onlyNumbers = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = onlyNumbers.startIndex
        for char in mask where index < onlyNumbers.endIndex {
            if char == "X" {
                result.append(onlyNumbers[index])
                index = onlyNumbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        
        if textIsEditing == false && !newString.isEmpty {
            self.textIsEditing = true
            update(state: .active, animated: true)
        }
        
        for char in string {
            if !char.isNumber {
                update(state: .error(message: "Можно вводить только цифры"), animated: true)
                textField.text = newString
                return false
            }
            update(state: .active, animated: true)
        }
        
        let mask = "XXX XXX XX XX"
        if newString.count == mask.count+1 { return false }
        
        let newText = phoneFormatter(
            mask: mask,
            number: newString)
        
        update(state: .active, animated: true)
        
        textField.text = newText
        
        if textIsEditing == true && newText.isEmpty {
            self.textIsEditing = false
            update(state: .error(message: "Заполните поле"), animated: true)
        }
        
        if string.count == 0 || text.count > newText.count {
            guard let deletePosition = textField.position(
                from: textField.beginningOfDocument,
                offset: range.location+string.count) else { return false }
            
            textField.selectedTextRange = textField.textRange(from: deletePosition, to: deletePosition)
        } else {
            let charArray = Array(newText)
            var location = 0
            for index in range.location+range.length..<charArray.count {
                if charArray[index].isNumber{
                    location = index+1
                    break
                }
            }
            guard let insertPosition = textField.position(
                from: textField.beginningOfDocument,
                offset: location) else { return false }
            
            textField.selectedTextRange = textField.textRange(from: insertPosition, to: insertPosition)
        }
        
        return false
        
    }
}
