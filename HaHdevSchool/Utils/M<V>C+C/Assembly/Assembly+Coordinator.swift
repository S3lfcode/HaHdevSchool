import Foundation
import UIKit

extension Assembly {
        
    func appCoordinator() -> AppCoordinator {
        AppCoordinator(assembly: self, root: navigationController)
    }
    
    func authCoordinator() -> AuthCoordinator {
        AuthCoordinator(assembly: self, root: navigationController)
    }
    
    func verificationCoordinator() -> VerificationCoordinator {
        VerificationCoordinator(assembly: self, root: navigationController)
    }

}
