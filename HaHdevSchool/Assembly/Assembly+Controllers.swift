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
    
    func authController() -> AuthVC<AuthViewImp> {
        .init(authProvider: authProvider)
    }
    
    func verificationController(phone: String, seconds: Int) -> VerificationVC<VerificationViewImp> {
        .init(phone: phone, seconds: seconds)
    }
    
    func catalogController() -> CatalogVC<CatalogViewImp> {
        .init(priceFormatter: priceFormatter)
    }
    
}

//MARK: Components
extension Assembly {
    
    func phoneTextFieldController() -> PhoneTextFieldVC<PhoneTextFieldViewImp> {
        .init()
    }
    
}
