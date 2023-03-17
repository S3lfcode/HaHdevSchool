import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 252/255, green: 232/255, blue: 232/255, alpha: 1)
        
        view.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(loginButton)
        
        let containerViewCenterYConstant = containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        self.containerViewCenterYConstant = containerViewCenterYConstant
        
        NSLayoutConstraint.activate(
            [
                containerView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
                containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
                containerView.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
                
                containerViewCenterYConstant,
                
                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
                titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
                titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
                
                phoneTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
                phoneTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
                phoneTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
                
                loginButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 30),
                loginButton.centerXAnchor.constraint(equalTo: phoneTextField.centerXAnchor),
                loginButton.widthAnchor.constraint(equalTo: phoneTextField.widthAnchor, multiplier: 0.5),
                loginButton.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    enum Constants {
        static let padding: CGFloat = 16
        static let space: CGFloat = 30
        static let cornerRadius: CGFloat = 20
    }
    
    private var containerViewCenterYConstant: NSLayoutConstraint?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 244/255, green: 200/255, blue: 200/255, alpha: 1.0)
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
        label.layer.borderColor = CGColor(red: 50/255, green: 50/255, blue: 255/255, alpha: 0.3)
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Авторизация"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = Constants.cornerRadius
        label.layer.borderWidth = 1
        //        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        //        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    lazy var phoneTextField: MaterialTextField = {
        let textField = MaterialTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.font = .systemFont(ofSize: 25, weight: .medium)
//        textField.textColor = .black
//        textField.attributedPlaceholder = .init(string: "  Телефон", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 190/255, green: 179/255, blue: 167/255, alpha: 0.5)])
//        textField.layer.masksToBounds = true
//        textField.layer.cornerRadius = Constants.cornerRadius
        //textField.delegate = self
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 255/255, alpha: 0.8)
        button.setTitle("Вход", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = Constants.cornerRadius
        //        button.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        //        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return button
    }()
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let constraint = self.containerViewCenterYConstant else { return }
            moveViewWithKeyboard(notification: notification, viewConstraint: constraint, keyboardWillShow: true)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let constraint = self.containerViewCenterYConstant else { return }
        moveViewWithKeyboard(notification: notification, viewConstraint: constraint, keyboardWillShow: false)
    }
    
    func moveViewWithKeyboard(notification: NSNotification, viewConstraint: NSLayoutConstraint, keyboardWillShow: Bool) {
        
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        
        guard let userInfo = notification.userInfo,
            let keyboardDuration = (userInfo[durationKey] as? NSNumber)?.doubleValue,
            let curveValue = (userInfo[curveKey] as? NSNumber)?.intValue,
            let keyboardCurve = UIView.AnimationCurve(rawValue: curveValue),
            let keyboardSize = (userInfo[frameKey] as? NSValue)?.cgRectValue
            else { return }
        
        if keyboardWillShow {
            view.backgroundColor = .gray
            
            let distanceTextFieldToBottom = view.bounds.maxY - (containerView.frame.minY + phoneTextField.frame.maxY)
            if keyboardSize.height < distanceTextFieldToBottom { return }
            
            viewConstraint.constant = containerView.frame.midY - (containerView.bounds.midY - (containerView.bounds.maxY - phoneTextField.frame.maxY)) - keyboardSize.height
        } else {
            view.backgroundColor = UIColor(red: 252/255, green: 232/255, blue: 232/255, alpha: 1)
            viewConstraint.constant = 0
        }
        
        UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        }.startAnimation()

    }
}

//extension ViewController: UITextFieldDelegate {
//
//    private func phoneFormatter(mask: String, number: String) -> String {
//        let onlyNumbers = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//        var result = ""
//        var index = onlyNumbers.startIndex
//        for char in mask where index < onlyNumbers.endIndex {
//            if char == "X" {
//                result.append(onlyNumbers[index])
//                index = onlyNumbers.index(after: index)
//            } else {
//                result.append(char)
//            }
//        }
//        return result
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else {return false}
//
//        let newString = (text as NSString).replacingCharacters(in: range, with: string)
//
//        let mask = "+X (XXX) XXX-XX-XX"
//        if newString.count == mask.count+1 { return false }
//
//        textField.text = phoneFormatter(
//            mask: mask,
//            number: newString)
//
//        if string.count == 0 {
//            guard let deletePosition = textField.position(
//                from: textField.beginningOfDocument,
//                offset: range.location) else { return false }
//
//            textField.selectedTextRange = textField.textRange(from: deletePosition, to: deletePosition)
//        } else {
//            guard let finalText = textField.text else { return false }
//
//            let charArray = Array(finalText)
//            var location = 0
//            for index in range.location+range.length..<charArray.count {
//                if charArray[index].isNumber{
//                    location = index+1
//                    break
//                }
//            }
//
//            guard let insertPosition = textField.position(
//                from: textField.beginningOfDocument,
//                offset: location) else { return false }
//
//            textField.selectedTextRange = textField.textRange(from: insertPosition, to: insertPosition)
//        }
//
//        return false
//    }
//}
