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
        context: VerificationCoordinator.Context
    ) -> VerificationCoordinator {
        .init(assembly: self, context: context)
    }

}
