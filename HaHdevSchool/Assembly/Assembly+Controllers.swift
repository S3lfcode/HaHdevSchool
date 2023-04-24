import Foundation
import UIKit

//MARK: Navigations
extension Assembly {
    
    var navigationController: UINavigationController {
        .init()
    }
    
}

//MARK: Screens
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
    
    func catalogController() -> CatalogController<CatalogViewImp> {
        .init()
    }
    
}

//MARK: Components
extension Assembly {
    
    func phoneTextFieldController() -> PhoneTextFieldController<PhoneTextFieldViewImp> {
        .init()
    }
    
}
