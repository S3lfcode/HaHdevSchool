import UIKit

protocol AuthView: UIView {
    var containerViewTopAnchorYConstraint: NSLayoutConstraint? {get}
    var logoImageViewTopAnchorYConstraint: NSLayoutConstraint? {get}
    var logoImageView: UIImageView {get}
    var loginButton: UIButton {get}
    var phoneTextField: AuthTextField {get}
    
    
    var onVerificationAction: ((String) -> Void)? { get set }
    func updateTextFieldState(state: AuthTextField.Status, animated: Bool)
    func startAnimation()
    func stopAnimation()
}

class AuthViewImp: UIView, AuthView{
    
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
        addSubview(logoImageView)
        addSubview(containerView)
        addSubview(socialMediaContainer)
        addSubview(loadingImageView)
    }
    
    func setupConstraints() {
        
        let containerViewTopAnchorYConstraint = containerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor)
        self.containerViewTopAnchorYConstraint = containerViewTopAnchorYConstraint
        
        let logoImageViewTopAnchorYConstraint = logoImageView.topAnchor.constraint(equalTo: topAnchor)
        self.logoImageViewTopAnchorYConstraint = logoImageViewTopAnchorYConstraint
        
        NSLayoutConstraint.activate(
            [
                logoImageViewTopAnchorYConstraint,
                logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                
                containerViewTopAnchorYConstraint,
                containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Margin.horizontal),
                containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Margin.horizontal),
                
                socialMediaContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
                socialMediaContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                loadingImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                loadingImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ]
        )
    }
    
    var containerViewTopAnchorYConstraint: NSLayoutConstraint?
    var logoImageViewTopAnchorYConstraint: NSLayoutConstraint?
    
    enum Constants {
        enum Margin {
            static let horizontal: CGFloat = 30
        }
        static let padding: CGFloat = 16
    }
    
    private var stackViewSubviews: [UIView] {
        [
            titleLabel,
            phoneContainerStackView,
            loginButton
        ]
    }
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Auth/Logo")
        return imageView
    }()
    
    lazy var containerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: stackViewSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 30
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ВХОД ИЛИ\nРЕГИСТРАЦИЯ"
        label.textColor = UIColor(named: "Colors/Grayscale/black")
        label.font = UIFont(name: "GothamSSm-BlackItalic", size: 26)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var numberCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "+7"
        label.textAlignment = .center
        label.textColor = UIColor(named: "Colors/Phone/placeholder")
        label.backgroundColor = UIColor(named: "Colors/Phone/background")
        label.font = UIFont(name: "GothamSSm-Book", size: 14)
        label.heightAnchor.constraint(equalToConstant: 56).isActive = true
        label.widthAnchor.constraint(equalToConstant: 45).isActive = true
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 6
        return label
    }()
    
    lazy var phoneTextField: AuthTextField = {
        let textField = AuthTextField()
        return textField
    }()
    
    private var stackPhoneSubviews: [UIView] {
        [
            numberCodeLabel,
            phoneTextField
        ]
    }
    
    lazy var phoneContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: stackPhoneSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 9
        return stackView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Colors/Primary/blue")
        button.setTitle("Получить код", for: .normal)
        button.setTitleColor(UIColor(named: "Colors/white"), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamSSm-Medium", size: 15)
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.addTarget(self, action: #selector(didVerification), for: .touchUpInside)
        return button
    }()
    
    lazy var appleButton: AuthSocialMediaButton = {
        let button = AuthSocialMediaButton()
        button.configure(
            image: UIImage(named: "Auth/SocialMedia/apple"),
            color: UIColor(named: "Colors/Grayscale/black")
        )
        return button
    }()
    
    lazy var vkButton: AuthSocialMediaButton = {
        let button = AuthSocialMediaButton()
        button.configure(
            image: UIImage(named: "Auth/SocialMedia/VK"),
            color: UIColor(named: "Colors/Primary/social/socialLight")
        )
        return button
    }()
    
    lazy var odnoklassnikiButton: AuthSocialMediaButton = {
        let button = AuthSocialMediaButton()
        button.configure(
            image: UIImage(named: "Auth/SocialMedia/Odnoklassniki"),
            color: UIColor(named: "Colors/Primary/social/socialLight")
        )
        return button
    }()
    
    lazy var facebookButton: AuthSocialMediaButton = {
        let button = AuthSocialMediaButton()
        button.configure(
            image: UIImage(named: "Auth/SocialMedia/Facebook"),
            color: UIColor(named: "Colors/Primary/social/socialLight")
        )
        return button
    }()
    
    private var stackSocialMediaSubviews: [UIView] {
        [
            appleButton,
            vkButton,
            odnoklassnikiButton,
            facebookButton
        ]
    }
    
    lazy var socialMediaContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: stackSocialMediaSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var loadingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Auth/Loading")
        imageView.isHidden = true
        return imageView
    }()
    
    func startAnimation() {
        loadingImageView.isHidden = false
        
        var turnByDegree = 0
        var duration = 0
        for _ in 0...5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(duration)) {
                self.layoutIfNeeded()
                self.loadingImageView.transform = .init(rotationAngle: CGFloat(turnByDegree))
                turnByDegree -= 18
                self.setNeedsLayout()
            }
            duration += 500
        }
    }
    
    func stopAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            self.loadingImageView.isHidden = true
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    var onVerificationAction: ((String) -> Void)?
    
    // MARK: ButtonAction
    @objc func didVerification() {
        guard let phoneText = phoneTextField.textField.text else {return}
        
        // MARK: Сюда крутилку
        self.onVerificationAction?(phoneText)
    }
    
    // MARK: UpdateTextFieldState
    func updateTextFieldState(state: AuthTextField.Status, animated: Bool) {
        phoneTextField.update(status: state, animated: animated)
    }
    
}
