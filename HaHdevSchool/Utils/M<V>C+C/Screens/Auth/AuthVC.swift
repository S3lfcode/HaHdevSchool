import UIKit

final class AuthVC<View: AuthView>: BaseViewController<View> {
    typealias Completion = () -> Void
    
    struct InputForm {
        var phone: String?
    }
    
    var inputForm = InputForm(phone: "")
    
    var onVerification: ((_  phone: String?, _ completion: @escaping Completion) -> Void)?
    
    private let authProvider: AuthProvider
    
    init(authProvider: AuthProvider) {
        self.authProvider = authProvider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.onVerificationAction = { [weak self] in
            self?.rootView.endEditing(true)
            self?.verify(phone: self?.inputForm.phone)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rootView.connectKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        rootView.disconnectKeyboard()
    }
}

// MARK: Verification logic
private extension AuthVC {
    
    func validate(text: String?) -> Bool {
        guard
            let text = text,
            !text.isEmpty,
            text.filter({ $0 != " " && $0.isNumber }).count == 10
        else {
            return false
        }

        return true
    }
    
    func verify(phone: String?) {
        
        if !validate(text: phone) {
            return
        }
        
        rootView.displayLoading(enable: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.onVerification?(phone) {
                print("Complete onVerification")
            }
            self.rootView.displayLoading(enable: false)
        }
    }
}
