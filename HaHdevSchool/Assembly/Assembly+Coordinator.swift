import Foundation
import UIKit

extension Assembly {
        
    func appCoordinator() -> AppCoordinator {
        AppCoordinator(assembly: self)
    }
    
    func authCoordinator() -> AuthCoordinator {
        AuthCoordinator(assembly: self)
    }
    
    func verificationCoordinator(
        context: AuthCoordinator.Context
    ) -> VerificationCoordinator {
        .init(assembly: self, context: context)
    }
    
    func phoneTextFieldCoordinator(
        context: AuthCoordinator.PhoneContext
    ) -> PhoneTextFieldCoordinator {
        .init(assembly: self, context: context)
    }
}
