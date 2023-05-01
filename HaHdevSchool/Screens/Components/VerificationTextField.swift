import Foundation
import UIKit

class VerificationTextField: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textFieldStackView)
        addSubview(imageStackView)
        
        textFieldStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageStackView.centerXAnchor.constraint(equalTo: textFieldStackView.centerXAnchor).isActive = true
        imageStackView.centerYAnchor.constraint(equalTo: textFieldStackView.centerYAnchor).isActive = true
        
        textFieldViewContainer[0].isUserInteractionEnabled = true
        textFieldViewContainer[0].becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var textFieldViewContainer: [UITextField] = {
        var container: [UITextField] = []
        for index in 0...3 {
            container.append(UITextField())
            textFieldConfigure(textField: container[index])
        }
        return container
    }()
    
    lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: textFieldViewContainer)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.frame.size.width = 142
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var imageViewContainer = {
        var container: [UIView] = []
        for _ in 0...3 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "Auth/VerificationPlaceholder")
            container.append(imageView)
        }
        return container
    }()
    
    lazy var imageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: imageViewContainer)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.frame.size.width = 142
        stackView.axis = .horizontal
        stackView.spacing = 35
        return stackView
    }()
    
    func textFieldConfigure(textField: UITextField) {
        textField.font = UIFont(name: "GothamSSm-Book", size: 40)
        textField.keyboardType = .asciiCapableNumberPad
        textField.attributedPlaceholder = NSAttributedString(
            string: "X",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.textAlignment = .center
        textField.tintColor = UIColor.clear
        textField.isUserInteractionEnabled = false
        textField.delegate = self
    }
    
}

extension VerificationTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !validator(text: string) {
            return false
        }
        
        let textFieldContainer = textFieldViewContainer
        let dotContainer = imageViewContainer

        let currentIndex = textFieldContainer.lastIndex { $0.text == textField.text }
        guard var currentIndex = currentIndex else { return false }
        
        if textFieldContainer[0].text == "" { currentIndex = 0 }
        
        for iteration in 0..<string.count where string.count>0{
            let code = Array(string)
            let num = String(code[iteration])
            
            guard textFieldContainer.last?.text == "" else { return false }
            
            if textField.text == "" {
                textField.text = num
                dotContainer[currentIndex].alpha = 0
            } else {
                textFieldContainer[currentIndex+1].text = num
                setNewResponder(currentResonder: currentIndex, inserting: true)
                currentIndex += 1
            }
        }
        
        if string.count == 0 {
            textField.text = ""
            
            if currentIndex == 0 {
                dotContainer[currentIndex].alpha = 1
            } else {
                setNewResponder(currentResonder: currentIndex, inserting: false)
            }
        }
        return false
    }
    
    func setNewResponder(currentResonder index: Int, inserting: Bool) {
        
        if inserting {
            imageViewContainer[index+1].alpha = 0
            textFieldViewContainer[index+1].isUserInteractionEnabled = true
            textFieldViewContainer[index+1].becomeFirstResponder()
        } else {
            imageViewContainer[index].alpha = 1
            textFieldViewContainer[index-1].isUserInteractionEnabled = true
            textFieldViewContainer[index-1].becomeFirstResponder()
        }
        
        textFieldViewContainer[index].isUserInteractionEnabled = false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let end = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: end, to: end)
    }
    
    func validator(text: String) -> Bool {
        return !text.contains {
            !$0.isNumber
        }
    }
}
