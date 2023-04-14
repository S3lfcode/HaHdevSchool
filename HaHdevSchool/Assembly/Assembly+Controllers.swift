import Foundation
import UIKit

extension Assembly {
    
    var authProvider: AuthProvider {
        AuthProviderImp()
    }
    
    func authController() -> AuthController<AuthViewImp> {
        .init(authProvider: authProvider)
    }
    
    func verificationController(phone: String, seconds: Int) -> VerificationController<VerificationViewImp> {
        .init(phone: phone, seconds: seconds)
    }
}
