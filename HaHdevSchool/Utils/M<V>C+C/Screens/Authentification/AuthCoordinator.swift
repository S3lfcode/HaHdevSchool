import UIKit

class AuthCoordinator: Coordinator {    
    
    init(assembly: Assembly, root: UINavigationController) {
        self.assembly = assembly
        self.root = root
    }
    
    let assembly: Assembly
    let root: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    var childs: [Coordinator] = []
    
    func start() {
        let authController = assembly.authController()
        
        authController.onVerification = { [weak self] phone in
            guard let self = self else {
                return
            }
            
            print("Отправлено смс для верификации номера:\n +7 \(String(describing: phone))")
            
            let verificationCoordinator = VerificationCoordinator(assembly: self.assembly, root: self.root)
            
            self.switchTo(coordinator: verificationCoordinator)
        }
        
        root.pushViewController(authController, animated: !root.viewControllers.isEmpty)
    }
}
