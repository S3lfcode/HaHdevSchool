import Foundation
import UIKit

protocol VerificationView: UIView {
    func updateTimer(text: String)
}

class VerificationViewImp: UIView, VerificationView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "Colors/white")
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    func setupView() {
        addSubview(backButton)
        addSubview(stackView)
    }
    
    func setupConstraints() {
        
        let stackViewTopAnchor = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 158)
        
        
        NSLayoutConstraint.activate(
            [
                backButton.topAnchor.constraint(equalTo: topAnchor, constant: 57),
                backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
                
                stackViewTopAnchor,
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Margin.horizontal),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Margin.horizontal)

            ]
        )
    }
    
    enum Constants {
        enum Margin {
            static let horizontal: CGFloat = 30
        }
        static let padding: CGFloat = 16
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Auth/BackButton"), for: .normal)
        return button
    }()
    
    private var stackViewSubviews: [UIView] {
        [
            titleLabel,
            phoneInfoLabel,
            verificationTextField,
            resendingStackView
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
        label.text = "Получить новый код можно через"
        label.textColor = UIColor(named: "Colors/Grayscale/midGray")
        label.font = UIFont(name: "GothamSSm-Book", size: 14)
        return label
    }()
    
    lazy var resendingTimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "00:40"
        label.font = UIFont(name: "GothamSSm-Book", size: 14)
        label.textColor = UIColor(named: "Colors/Grayscale/midGray")
        return label
    }()
    
    func updateTimer(text: String) {
        resendingTimerLabel.text = text
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
        stackView.spacing = 2
        return stackView
    }()
    
}
