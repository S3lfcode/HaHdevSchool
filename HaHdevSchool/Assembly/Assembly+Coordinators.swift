import Foundation
import UIKit

//MARK: Screens
extension Assembly {
        
    func appCoordinator() -> AppCoordinator {
        .init(assembly: self)
    }
    
    func authCoordinator() -> AuthCoordinator {
        .init(assembly: self)
    }
    
    func verificationCoordinator(
        context: VerificationContext
    ) -> VerificationCoordinator {
        .init(assembly: self, context: context)
    }

    func catalogCoordinator() -> CatalogCoordinator {
        .init(assembly: self)
    }
}

//MARK: Components
extension Assembly {
    
    func phoneTextFieldCoordinator(
        context: PhoneTextFieldContext
    ) -> PhoneTextFieldCoordinator {
        .init(assembly: self, context: context)
    }
    
}
