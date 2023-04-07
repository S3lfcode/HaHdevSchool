import Foundation
import UIKit
//protocol VarificationTextField {
//    var onTextFieldEditing: ((UITextField, NSRange, String) -> Void)? { get set }
//}

class VerificationTextField: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textFieldStackView)
        addSubview(dotStackView)
        
        textFieldStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        dotStackView.centerXAnchor.constraint(equalTo: textFieldStackView.centerXAnchor).isActive = true
        dotStackView.centerYAnchor.constraint(equalTo: textFieldStackView.centerYAnchor).isActive = true
        
        firstTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var firstTextField: UITextField = {
        return textFieldConfigure()
    }()
    
    lazy var secondTextField: UITextField = {
        return textFieldConfigure()
    }()
    
    lazy var thirdTextField: UITextField = {
        return textFieldConfigure()
    }()
    
    lazy var fourthTextField: UITextField = {
        return textFieldConfigure()
    }()
    
    func textFieldConfigure() -> UITextField {
        let textField = UITextField()
        textField.font = UIFont(name: "GothamSSm-Book", size: 40)
        textField.keyboardType = .asciiCapableNumberPad
        textField.attributedPlaceholder = NSAttributedString(
            string: "X",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.textAlignment = .center
        textField.tintColor = UIColor.clear
        textField.delegate = self
        return textField
    }
    
    private var stackTextFieldSubviews: [UITextField] {
        [
            firstTextField,
            secondTextField,
            thirdTextField,
            fourthTextField
        ]
    }
    
    lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: stackTextFieldSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.frame.size.width = 142
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var firstDotImageView: UIImageView = {
        return dotImageConfigure()
    }()
    
    lazy var secondDotImageView: UIImageView = {
        return dotImageConfigure()
    }()
    
    lazy var thirdDotImageView: UIImageView = {
        return dotImageConfigure()
    }()
    
    lazy var fourthDotImageView: UIImageView = {
        return dotImageConfigure()
    }()
    
    func dotImageConfigure() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Auth/VerificationPlaceholder")
        return imageView
    }
    
    private var stackDotViewSubviews: [UIView] {
        [
            firstDotImageView,
            secondDotImageView,
            thirdDotImageView,
            fourthDotImageView
        ]
    }
    
    lazy var dotStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: stackDotViewSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.frame.size.width = 142
        stackView.axis = .horizontal
        stackView.spacing = 35
        return stackView
    }()
    
    // MARK: замыкание на эдит
    var onTextFieldEditing: ((UITextField, NSRange, String) -> Void)?
}

extension VerificationTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //onTextFieldEditing?(textField, range, string)
        
        let textFieldContainer = stackTextFieldSubviews
        let dotContainer = stackDotViewSubviews
        
        
        
        let currentIndex = textFieldContainer.lastIndex { $0.text == textField.text }
        guard var currentIndex = currentIndex else { return false }
        
        if textFieldContainer[0].text == "" { currentIndex = 0 }
        
        switch string.count {
        case 1 where textFieldContainer.last?.text == "" && textField.text == "":
            textField.text = string
            dotContainer[currentIndex].alpha = 0
            break
        case 1 where textFieldContainer.last?.text == "":
            textFieldContainer[currentIndex+1].text = string
            dotContainer[currentIndex+1].alpha = 0
            textFieldContainer[currentIndex+1].becomeFirstResponder()
            break
        case 0 where currentIndex == 0:
            textField.text = ""
            dotContainer[currentIndex].alpha = 1
            break
        case 0:
            textField.text = ""
            dotContainer[currentIndex].alpha = 1
            textFieldContainer[currentIndex-1].becomeFirstResponder()
            break
        default:
            break
        }
        
        return false
    }
    
    func setCursorToTextfieldEnd(_ textfield: UITextField) {
        let end = textfield.endOfDocument
        textfield.selectedTextRange = textfield.textRange(from: end, to: end)
    }
}
