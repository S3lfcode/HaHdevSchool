import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1.0)
        
        view.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(loginButton)
        
    }
    
    enum Constants {
        static let padding: CGFloat = 16
        static let space: CGFloat = 30
        static let cornerRadius: CGFloat = 20
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = view.bounds.width - 2 * Constants.padding
        
        let labelSize = titleLabel.sizeThatFits(
            .init(width: width, height: view.bounds.height)
        )
        
        containerView.frame = .init(
            x: Constants.padding,
            y: 50,
            width: width,
            height: 250 + labelSize.height)
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.center = view.center
        
        let containerWidth = containerView.bounds.width - 2 * Constants.padding
        
        titleLabel.frame = .init(
            x: Constants.padding,
            y: 50,
            width: containerWidth,
            height: labelSize.height)
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = Constants.cornerRadius
        
        phoneTextField.frame = .init(
            x: Constants.padding,
            y: titleLabel.frame.maxY + Constants.space,
            width: containerWidth,
            height: 50)
        phoneTextField.layer.cornerRadius = Constants.cornerRadius
        
        loginButton.frame = .init(
            x: containerView.bounds.midX-containerWidth/4,
            y: phoneTextField.frame.maxY + Constants.space,
            width: containerWidth/2,
            height: 50)
        loginButton.layer.cornerRadius = Constants.cornerRadius
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 252/255, green: 232/255, blue: 232/255, alpha: 1)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 5
        label.text = "Авторизация"
        label.textAlignment = .center
        return label
    }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = .systemFont(ofSize: 25, weight: .medium)
        textField.textColor = .black
        textField.attributedPlaceholder = .init(string: "  Телефон", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 190/255, green: 179/255, blue: 167/255, alpha: 0.5)])
        textField.delegate = self
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Вход", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        return button
    }()
}

extension ViewController: UITextFieldDelegate {
    
    private func phoneFormatter(mask: String, number: String) -> String {
        let phoneNum = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = "  "
        var index = phoneNum.startIndex
        for char in mask where index < phoneNum.endIndex {
            if char == "X" {
                result.append(phoneNum[index])
                index = phoneNum.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        
        textField.text = phoneFormatter(mask: "+X (XXX) XXX-XX-XX", number: newString)
        
        return false
    }
    
}
