import UIKit

class ViewController: UIViewController {
    
    // MARK: Вывод значения скрол view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("[ScrollView] frame \(scrollView.frame), bounds \(scrollView.bounds), contentSize \(scrollView.contentSize), stackView frame \(stackView.frame)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 252/255, green: 232/255, blue: 232/255, alpha: 1)
        
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // MARK: ??
        view.addSubview(scrollView)
        
        scrollView.contentInset = .init(
            top: Constants.headerView + 64,
            left: Constants.padding,
            bottom: 500,
            right: Constants.padding
        )
        scrollView.addSubview(stackView)
        
        view.addSubview(headerView)
        
        let headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: Constants.headerView)
        self.headerViewHeightConstraint = headerViewHeightConstraint
        
        
        NSLayoutConstraint.activate(
            [
                headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                // MARK: trailing, leading
                headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                headerViewHeightConstraint,
                
                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                
                stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
            ]
        )
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.keyboardWillShow),
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil
//        )
//        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.keyboardWillHide),
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil
//        )
//        
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    enum Constants {
        static let padding: CGFloat = 16
        static let cornerRadius: CGFloat = 20
        static let headerView: CGFloat = 300
    }
    
    private var stackViewCenterConstraint: NSLayoutConstraint?
    
    private var headerViewHeightConstraint: NSLayoutConstraint?
    
    private var stackViewSubviews: [UIView] {
        [
            titleLabel,
            phoneTextField,
            loginButton
        ]
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: view.bounds)
        view.backgroundColor = UIColor(red: 244/255, green: 200/255, blue: 200/255, alpha: 1.0)
        view.contentInsetAdjustmentBehavior = .never
        view.delegate = self
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: stackViewSubviews)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 244/255, green: 200/255, blue: 200/255, alpha: 1.0)
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 30
        return view
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
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
        return label
    }()
    
    lazy var phoneTextField: MaterialTextField = {
        let textField = MaterialTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        return button
    }()
    
//    @objc func keyboardWillShow(_ notification: NSNotification) {
//        guard let constraint = self.containerViewCenterYConstant else { return }
//            moveViewWithKeyboard(notification: notification, viewConstraint: constraint, keyboardWillShow: true)
//    }
//
//    @objc func keyboardWillHide(_ notification: NSNotification) {
//        guard let constraint = self.containerViewCenterYConstant else { return }
//        moveViewWithKeyboard(notification: notification, viewConstraint: constraint, keyboardWillShow: false)
//    }
//
//    func moveViewWithKeyboard(notification: NSNotification, viewConstraint: NSLayoutConstraint, keyboardWillShow: Bool) {
//
//        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
//        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
//        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
//
//        guard let userInfo = notification.userInfo,
//            let keyboardDuration = (userInfo[durationKey] as? NSNumber)?.doubleValue,
//            let curveValue = (userInfo[curveKey] as? NSNumber)?.intValue,
//            let keyboardCurve = UIView.AnimationCurve(rawValue: curveValue),
//            let keyboardSize = (userInfo[frameKey] as? NSValue)?.cgRectValue
//            else { return }
//
//        if keyboardWillShow {
//            view.backgroundColor = .gray
//
//            let distanceTextFieldToBottom = view.bounds.maxY - (containerView.frame.minY + phoneTextField.frame.maxY)
//            if keyboardSize.height < distanceTextFieldToBottom { return }
//
//            viewConstraint.constant = containerView.frame.midY - (containerView.bounds.midY - (containerView.bounds.maxY - phoneTextField.frame.maxY)) - keyboardSize.height
//        } else {
//            view.backgroundColor = UIColor(red: 252/255, green: 232/255, blue: 232/255, alpha: 1)
//            viewConstraint.constant = 0
//        }
//
//        UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
//            guard let self = self else { return }
//            self.view.layoutIfNeeded()
//        }.startAnimation()
//
//    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let diff = scrollView.contentInset.top + scrollView.contentOffset.y
        let newValue = Constants.headerView - diff
        
        // >=20 и headreView
        headerViewHeightConstraint?.constant = min(max(newValue, 20), Constants.headerView)
        
        view.layoutIfNeeded()
    }
}
