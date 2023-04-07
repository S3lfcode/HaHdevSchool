import Foundation
import UIKit

extension Assembly {
    
    var authProvider: AuthProvider {
        AuthProviderImp()
    }
    
    var navigationController: UINavigationController {
        let navVC = UINavigationController()
        //navVC.editButtonItem.customView = UIImageView(image: .init(named: "Auth/BackButton"))
        return navVC
    }
    
    func authController() -> AuthController<AuthViewImp> {
        AuthController<AuthViewImp>(authProvider: authProvider)
    }
    
    func verificationController() -> VerificationController<VerificationViewImp> {
        VerificationController<VerificationViewImp>(authProvider: authProvider)
    }
}
