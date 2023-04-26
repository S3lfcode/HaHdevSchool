import Foundation
import UIKit

final class VerificationViewImp: UIView, VerificationView {
    var onBack: (() -> Void)?
    
    var groundToken: Any?
    var appDidEnterBackgroundDate: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "Colors/white")
        
        addSubview(stackView)
        
        let stackViewTopAnchor = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 158)
        
        NSLayoutConstraint.activate(
            [
                stackViewTopAnchor,
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Margin.horizontal),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Margin.horizontal)
                
            ]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    enum Constants {
        enum Margin {
            static let horizontal: CGFloat = 30
        }
        static let padding: CGFloat = 16
    }
    
    private var stackViewSubviews: [UIView] {
        [
            titleLabel,
            phoneInfoLabel,
            verificationTextField,
            resendingStackView,
            resendingButton,
        ]
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: stackViewSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 30
        stackView.setCustomSpacing(14, after: titleLabel)
        stackView.setCustomSpacing(10, after: resendingStackView)
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ВВЕДИТЕ КОД"
        label.font = UIFont(name: "GothamSSm-BlackItalic", size: 26)
        return label
    }()
    
    lazy var phoneInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправили код на номер\n+7 911 901 9999"
        label.textColor = UIColor(named: "Colors/Grayscale/black")
        label.font = UIFont(name: "GothamSSm-Book", size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var verificationTextField: VerificationTextField = {
        let textField = VerificationTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return textField
    }()
    
    lazy var resendingTextLabel: UILabel = {
        let label = UILabel()
        label.text = "  Получить новый код можно через"
        label.textAlignment = .right
        label.textColor = UIColor(named: "Colors/Grayscale/midGray")
        label.font = UIFont(name: "GothamSSm-Book", size: 14)
        return label
    }()
    
    lazy var resendingTimerLabel: UILabel = {
        let label = UILabel()
        label.text = " 00:00"
        label.font = UIFont(name: "GothamSSm-Book", size: 14)
        label.textColor = UIColor(named: "Colors/Grayscale/midGray")
        return label
    }()
    
    func updateState(state: State) {
        switch state {
        case .info(let text):
            phoneInfoLabel.text = "Мы отправили код на номер\n+7 \(text)"
            break
        case .timer(let seconds):
            
            switch seconds {
            case seconds where seconds>=10:
                resendingTimerLabel.text = " 00:\(seconds)"
                break
            case seconds where seconds>0 && seconds<10:
                resendingTimerLabel.text = " 00:0\(seconds)"
                break
            case seconds where seconds <= 0:
                resendingTimerLabel.text = " 00:00"
                break
            default:
                break
            }
            
            break
        }
    }
    
    private var stackResendingSubviews: [UIView]  {
        [
            resendingTextLabel,
            resendingTimerLabel
        ]
    }
    
    lazy var resendingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: stackResendingSubviews)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var resendingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Colors/white")
        button.setTitle("Отправить код повторно", for: .normal)
        button.setTitleColor(UIColor(named: "Colors/Primary/blue"), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamSSm-Book", size: 14)
        button.titleLabel?.textAlignment = .center
        button.isHidden = true
        return button
    }()
    
    @objc func toBack(sender: UIBarButtonItem) {
        onBack?()
    }
}

//MARK: Configuration navigation controller

extension VerificationViewImp {
    
    func configureNavController(navItem: UINavigationItem) {
        
        let backButton = UIBarButtonItem(
            image: UIImage(named: "Auth/backButton"),
            style: .done,
            target: self,
            action: #selector(toBack(sender:))
        )
        backButton.tintColor = UIColor(named: "Colors/Grayscale/black")
        navItem.leftBarButtonItem = backButton
        
    }
    
}
