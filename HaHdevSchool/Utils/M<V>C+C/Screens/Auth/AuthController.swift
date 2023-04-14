import UIKit

final class AuthController<View: AuthView>: BaseViewController<View> {
    typealias Completion = () -> Void
    
    struct InputForm {
        var phone: String?
    }
    
    private var inputForm = InputForm(phone: "")
    
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
        
        navigationController?.navigationBar.tintColor = .black
        
        rootView.onVerificationAction = { [weak self] phone in
            self?.verify(phone: phone)
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
private extension AuthController {
    
    func validate(text: String?) -> String? {
        guard let text = text, !text.isEmpty else {
            return "Заполните поле"
        }
        
        guard text.filter({ $0 != " " && $0.isNumber }).count == 10 else {
            return "Неверный формат номера"
        }
        
        return nil
    }
    
    func verify(phone: String?) {
        if let error = validate(text: phone) {
            rootView.updateStatus(error: error, animated: true)
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
