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
        addSubview(separatorView)
        addSubview(errorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.frame = textFieldFrame(state: state)
        placeholderLabel.frame = placeholderLabelFrame(state: state)
        separatorView.frame = separatorViewFrame(state: state)
        errorLabel.frame = errorLabelFrame(state: state)
        
        if bounds.height != errorLabel.frame.maxY {
            invalidateIntrinsicContentSize()
        }
    }
    
    private enum Constants {
        static let space: CGFloat = 10
        static let textFieldHeight: CGFloat = 50
        static let separatorHeight: CGFloat = 2
    }
    
    func textFieldFrame(state: State) -> CGRect {
        .init(
            x: 0,
            y: Constants.space,
            width: bounds.width,
            height: Constants.textFieldHeight)
    }
    
    private var textIsEditing: Bool = false
    
    func placeholderLabelFrame(state: State) -> CGRect {
        let size = placeholderLabel.sizeThatFits(.init(width: bounds.height, height: 0))
        
        if textIsEditing {
            return .init(
                x: 10,
                y: 0,
                width: size.width+10,
                height: size.height
            )
        }
        
        return .init(
            x: 10,
            y: Constants.textFieldHeight/4+Constants.space,
            width: size.width+10,
            height: size.height
        )
        
    }
    
    func separatorViewFrame(state: State) -> CGRect {
        .init(
            x: 10,
            y: Constants.textFieldHeight+Constants.space-7,
            width: bounds.width-20,
            height: Constants.separatorHeight
        )
    }
    
    func errorLabelFrame(state: State) -> CGRect {
        let size = errorLabel.sizeThatFits(.init(width: bounds.width, height: 0))
        
        return .init(
            x: 0,
            y: Constants.textFieldHeight + Constants.separatorHeight + Constants.space,
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
            separatorView.backgroundColor = .darkGray
            errorLabel.alpha = 0
            errorLabel.text = nil
            placeholderLabel.textColor = .black
            placeholderLabel.alpha = 0.5
        case .active:
            separatorView.backgroundColor = .blue
            errorLabel.alpha = 0
            errorLabel.text = nil
            placeholderLabel.textColor = .blue
            placeholderLabel.alpha = 1
        case .error(let message):
            separatorView.backgroundColor = .red
            errorLabel.alpha = 1
            errorLabel.text = message
            placeholderLabel.textColor = .red
            placeholderLabel.alpha = 1
        }
        setNeedsLayout()
    }
    
    override var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: errorLabel.frame.maxY)
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.delegate = self
        return textField
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Телефон"
        label.textAlignment = .center
        label.alpha = 0.5
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .red
        return label
    }()
    
    
}

extension MaterialTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        update(state: .active, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        update(state: .default, animated: true)
    }
    
    private func phoneFormatter(mask: String, number: String) -> String {
        let onlyNumbers = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        //let onlyNumbers = number
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
        
        let mask = "+X (XXX) XXX-XX-XX"
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
        
        if string.count == 0 {
            guard let deletePosition = textField.position(
                from: textField.beginningOfDocument,
                offset: range.location) else { return false }
            
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
