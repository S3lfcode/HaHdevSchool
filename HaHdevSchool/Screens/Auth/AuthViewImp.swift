import UIKit

final class AuthViewImp: UIView, AuthView {
    
    var keyboardToken: Any?
    var onVerificationAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "Colors/white")
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(logoImageView)
        addSubview(containerView)
        addSubview(socialMediaContainer)
    }
    
    private func setupConstraints() {
        
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
                socialMediaContainer.centerXAnchor.constraint(equalTo: centerXAnchor)
                
            ]
        )
    }
    
    private var containerViewTopAnchorYConstraint: NSLayoutConstraint?
    private var logoImageViewTopAnchorYConstraint: NSLayoutConstraint?
    
    private enum Constants {
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
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Auth/Logo")
        return imageView
    }()
    
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: stackViewSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 30
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ВХОД ИЛИ\nРЕГИСТРАЦИЯ"
        label.textColor = UIColor(named: "Colors/Grayscale/black")
        label.font = UIFont(name: "GothamSSm-BlackItalic", size: 26)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var numberCodeLabel: UILabel = {
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
    
    //MARK: ContainerView for phone
    private lazy var phoneContainer: UIControl = {
        let view = UIControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var stackPhoneSubviews: [UIView] {
        [
            numberCodeLabel,
            phoneContainer
        ]
    }
    
    private lazy var phoneContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: stackPhoneSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 9
        return stackView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Colors/Primary/blue")
        button.setTitle("Получить код", for: .normal)
        button.setTitleColor(UIColor(named: "Colors/white"), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamSSm-Medium", size: 15)
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.addTarget(self, action: #selector(didVerification), for: .touchUpInside)
        button.addSubview(loadingImageView)
        loadingImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        loadingImageView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        
        return button
    }()
    
    private  lazy var appleButton: AuthSocialMediaButton = {
        let button = AuthSocialMediaButton()
        button.configure(
            image: UIImage(named: "Auth/SocialMedia/apple"),
            color: UIColor(named: "Colors/Grayscale/black")
        )
        return button
    }()
    
    private lazy var vkButton: AuthSocialMediaButton = {
        let button = AuthSocialMediaButton()
        button.configure(
            image: UIImage(named: "Auth/SocialMedia/VK"),
            color: UIColor(named: "Colors/Primary/social/socialLight")
        )
        return button
    }()
    
    private lazy var odnoklassnikiButton: AuthSocialMediaButton = {
        let button = AuthSocialMediaButton()
        button.configure(
            image: UIImage(named: "Auth/SocialMedia/Odnoklassniki"),
            color: UIColor(named: "Colors/Primary/social/socialLight")
        )
        return button
    }()
    
    private lazy var facebookButton: AuthSocialMediaButton = {
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
    
    private lazy var socialMediaContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: stackSocialMediaSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var loadingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Auth/Loading")
        imageView.alpha = 0
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    func displayLoading(enable: Bool) {
        
        if !enable {
            phoneContainer.isUserInteractionEnabled = true
            loginButton.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.5) {
                self.loadingImageView.alpha = 0
                self.loginButton.titleLabel?.alpha = 1
            }
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.loginButton.titleLabel?.alpha = 0
        }
        UIView.animate(withDuration: 0.2, delay: 0.3) {
            self.loadingImageView.alpha = 1
        }
        
        phoneContainer.isUserInteractionEnabled = false
        loginButton.isUserInteractionEnabled = false
        
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.loadingImageView.transform = .init(rotationAngle: Double.pi/2)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.loadingImageView.transform = .init(rotationAngle: Double.pi)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.loadingImageView.transform = .init(rotationAngle: Double.pi*1.5)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.loadingImageView.transform = .init(rotationAngle: Double.pi*2)
            }
        })
    }
    
    @objc func didVerification() {
       self.onVerificationAction?()
    }
}

extension AuthViewImp: KeybordableView {
    
    func apply(keyboardHeight: CGFloat, keyboardWillShow: Bool) {
        
        if keyboardWillShow {
            containerViewTopAnchorYConstraint?.constant = -keyboardHeight/4
            logoImageViewTopAnchorYConstraint?.constant = -keyboardHeight/10
            logoImageView.alpha = 0.5
        } else {
            containerViewTopAnchorYConstraint?.constant = 0
            logoImageViewTopAnchorYConstraint?.constant = 0
            logoImageView.alpha = 1
        }
        
        layoutIfNeeded()
    }
}

extension AuthViewImp: ContainerView {
    
    enum ContainerID {
        case phone
    }
    
    func addSubview(view: UIView, by id: AuthViewImp.ContainerID, animated: Bool) {
        let container = container(by: id)
        
        if animated {
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = .fade
            container.layer.add(transition, forKey: nil)
        }
 
        container.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: container.topAnchor),
                view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
            ]
        )
    }
    
    func removeSubview(view: UIView, by id: AuthViewImp.ContainerID, animated: Bool) {
        let container = container(by: id)
        
        if animated {
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = .fade
            container.layer.add(transition, forKey: nil)
        }
        
        container.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    private func container(by id: AuthViewImp.ContainerID) -> UIView {
        switch id {
        case .phone:
            return phoneContainer
        }
    }
    
    
}
