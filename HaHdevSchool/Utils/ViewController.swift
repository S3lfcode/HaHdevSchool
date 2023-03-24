import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Colors/white")
        
        view.addSubview(logoImageView)
        view.addSubview(containerView)
        view.addSubview(socialMediaContainer)
        
        let containerViewTopAnchorYConstraint = containerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor)
        self.containerViewTopAnchorYConstraint = containerViewTopAnchorYConstraint
        
        let logoImageViewTopAnchorYConstraint = logoImageView.topAnchor.constraint(equalTo: view.topAnchor)
        self.logoImageViewTopAnchorYConstraint = logoImageViewTopAnchorYConstraint
        
        NSLayoutConstraint.activate(
            [
                logoImageViewTopAnchorYConstraint,
                logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                
                containerViewTopAnchorYConstraint,
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.horizontal),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.horizontal),
                
                socialMediaContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                socialMediaContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                
            ]
        )
        
    }
    
    private var containerViewTopAnchorYConstraint: NSLayoutConstraint?
    private var logoImageViewTopAnchorYConstraint: NSLayoutConstraint?
    
    enum Constants {
        enum Margin {
            static let horizontal: CGFloat = 30
        }
        static let padding: CGFloat = 16
    }
    
    private var stackViewCenterConstraint: NSLayoutConstraint?
    
    private var headerViewHeightConstraint: NSLayoutConstraint?
    
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
    
    
    lazy var phoneTextField: MaterialTextField = {
        let textField = MaterialTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "Colors/Phone/background")
        textField.layer.cornerRadius = 8
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
        return button
    }()
    
    lazy var appleButton: MaterialSocialMediaView = {
        let button = MaterialSocialMediaView()
        button.configure(
            image: UIImage(named: "Auth/SocialMedia/Apple"),
            color: UIColor(named: "Colors/Grayscale/black")
        )
        return button
    }()
    
    lazy var vkButton: MaterialSocialMediaView = {
        let button = MaterialSocialMediaView()
        button.configure(
            image: UIImage(named: "Auth/SocialMedia/VK"),
            color: UIColor(named: "Colors/Primary/Social/socialLight")
        )
        return button
    }()
    
    lazy var odnoklassnikiButton: MaterialSocialMediaView = {
        let button = MaterialSocialMediaView()
        button.configure(
            image: UIImage(named: "Auth/SocialMedia/Odnoklassniki"),
            color: UIColor(named: "Colors/Primary/Social/socialLight")
        )
        return button
    }()
    
    lazy var facebookButton: MaterialSocialMediaView = {
        let button = MaterialSocialMediaView()
        button.configure(
            image: UIImage(named: "Auth/SocialMedia/Facebook"),
            color: UIColor(named: "Colors/Primary/Social/socialLight")
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
        stackView.heightAnchor.constraint(equalToConstant: 46).isActive = true
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
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
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        moveViewWithKeyboard(notification: notification, keyboardWillShow: true)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        moveViewWithKeyboard(notification: notification, keyboardWillShow: false)
    }
    
    func moveViewWithKeyboard(notification: NSNotification, keyboardWillShow: Bool) {
        
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
//        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        
        guard let userInfo = notification.userInfo,
              let keyboardDuration = (userInfo[durationKey] as? NSNumber)?.doubleValue,
              let curveValue = (userInfo[curveKey] as? NSNumber)?.intValue,
              let keyboardCurve = UIView.AnimationCurve(rawValue: curveValue)
//            let keyboardSize = (userInfo[frameKey] as? NSValue)?.cgRectValue
        else { return }
        
        guard let containerConstraint = self.containerViewTopAnchorYConstraint else { return }
        guard let logoConstraint = self.logoImageViewTopAnchorYConstraint else {return}
        
        if keyboardWillShow {
            containerConstraint.constant = -150 + view.safeAreaInsets.top
            logoConstraint.constant = -50
            logoImageView.alpha = 0.5
        } else {
            containerConstraint.constant = 0
            logoConstraint.constant = 0
            logoImageView.alpha = 1
        }
        
        UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        }.startAnimation()
        
    }
}
