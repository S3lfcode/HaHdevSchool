import Foundation
import UIKit

extension Assembly {
        
    func appCoordinator() -> AppCoordinator {
        AppCoordinator(assembly: self, root: navigationController)
    }
    
    func authCoordinator() -> AuthCoordinator {
        AuthCoordinator(assembly: self, root: navigationController)
    }
    
    func verificationCoordinator(
        context: VerificationCoordinator.Context
    ) -> VerificationCoordinator {
        .init(assembly: self, root: navigationController, context: context)
    }

}
