import Foundation
import UIKit

extension Assembly {
    
    var authProvider: AuthProvider {
        AuthProviderImp()
    }
    
    var navigationController: UINavigationController {
        UINavigationController()
    }
    
    func authController() -> AuthController<AuthViewImp> {
        AuthController<AuthViewImp>(authProvider: authProvider)
    }
    
    func verificationController() -> VerificationController<VerificationViewImp> {
        VerificationController<VerificationViewImp>()
    }
}
