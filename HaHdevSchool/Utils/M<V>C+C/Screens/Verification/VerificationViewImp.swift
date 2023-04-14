import Foundation
import UIKit

class VerificationViewImp: UIView, VerificationView {
    
    var groundToken: Any?
    var appDidEnterBackgroundDate: Date?
    
    private var timer: Timer?
    private var timeLeft = 40
    
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
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    @objc func onTimerFires() {
        
        timeLeft -= 1
        
        switch timeLeft {
        case timeLeft where timeLeft >= 10:
            updateState(text: " 00:\(timeLeft)")
            break
        case timeLeft where timeLeft>0 && timeLeft<10:
            updateState(text: " 00:0\(timeLeft)")
            break
        case timeLeft where timeLeft <= 0:
            timer?.invalidate()
            updateState(text: " 00:00")
            timer = nil
            break
        default:
            break
        }
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
        label.text = " 00:40"
        label.font = UIFont(name: "GothamSSm-Book", size: 14)
        label.textColor = UIColor(named: "Colors/Grayscale/midGray")
        return label
    }()
    
    func updateState(text: String) {
        resendingTimerLabel.text = text
        if resendingTimerLabel.text == " 00:00" {
            resendingButton.isHidden = false
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
}

extension VerificationViewImp: ApplicationGroundView {
    func apply(secondsPassed: Int) {
        timeLeft -= secondsPassed
    }
}




