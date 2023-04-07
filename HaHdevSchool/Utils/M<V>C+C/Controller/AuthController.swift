import UIKit

class AuthController<View: AuthView>: BaseViewController<View> {
    
    var onVerification: ((String?) -> ())?
    
    init(
        authProvider: AuthProvider
    ) {
        self.authProvider = authProvider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    private let authProvider: AuthProvider
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView?.onVerificationAction = { [weak self] phone in
            guard let self = self else {return}
            
            if !self.phoneValidation(phone: phone) {
                self.rootView?.updateTextFieldState(state: .error(message: "Неверный формат номера"), animated: true)
                return
            }
            
            self.rootView?.startAnimation()
            self.onVerification?(phone)
            self.rootView?.stopAnimation()
        }
    }
    
    func phoneValidation(phone: String) -> Bool {
        
        let phone = phone.filter { char in
            char != " " && char.isNumber
        }
        return phone.count == 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
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
        //let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        
        guard let userInfo = notification.userInfo,
              let keyboardDuration = (userInfo[durationKey] as? NSNumber)?.doubleValue,
              let curveValue = (userInfo[curveKey] as? NSNumber)?.intValue,
              let keyboardCurve = UIView.AnimationCurve(rawValue: curveValue)
              //let keyboardSize = (userInfo[frameKey] as? NSValue)?.cgRectValue
        else { return }
        
        guard let rootView = rootView else {return}
        guard let containerConstraint = rootView.containerViewTopAnchorYConstraint else { return }
        guard let logoConstraint = rootView.logoImageViewTopAnchorYConstraint else {return}
        
        if keyboardWillShow {
            containerConstraint.constant = -150 + view.safeAreaInsets.top
            logoConstraint.constant = -50
            rootView.logoImageView.alpha = 0.5
        } else {
            containerConstraint.constant = 0
            logoConstraint.constant = 0
            rootView.logoImageView.alpha = 1
        }
        
        UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        }.startAnimation()
        
    }
}
