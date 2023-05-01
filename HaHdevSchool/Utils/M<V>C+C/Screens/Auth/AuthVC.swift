import UIKit

final class AuthVC<View: AuthView>: BaseViewController<View> {
    
    typealias Completion = () -> Void
    
    init(authProvider: AuthProvider) {
        self.authProvider = authProvider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let authProvider: AuthProvider
    
    private var phoneData: PhoneTextFieldOutputData?
    
    var onVerification: ((_  phone: String?, _ completion: @escaping Completion) -> Void)?
    
    var onDisplayPhoneError: ((PhoneTextFieldError?) -> Void)?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.onVerificationAction = { [weak self] in
            self?.verifyIfNeeded()
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
    
    func changeData(phoneData: PhoneTextFieldOutputData?) {
        self.phoneData = phoneData
    }
    
}

// MARK: Verification logic
private extension AuthVC {
    
    func verifyIfNeeded() {
        guard let phone = phoneData?.text else {
            onDisplayPhoneError?(.emptyField)
            return
        }
        
        if let error = self.phoneData?.error {
            onDisplayPhoneError?(error)
            return
        }
        
        verify(phone: phone)
        
    }
    
    func verify(phone: String) {
        
        rootView.displayLoading(enable: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            
            self.onVerification?(phone) {
                print("Complete onVerification")
            }
            
            self.rootView.displayLoading(enable: false)
        }
        
    }
}
