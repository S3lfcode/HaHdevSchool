import UIKit

class AuthCoordinator: Coordinator {    
    
    init(assembly: Assembly, root: UINavigationController) {
        self.assembly = assembly
        self.root = root
    }
    
    private let assembly: Assembly
    private let root: UINavigationController
    
    var childs: [Coordinator] = []
    
    func start() {
        let authController = assembly.authController()
        
        authController.onVerification = { [weak self] phone in
            guard let self = self else {return}
            
            print("Отправлено смс для верификации номера:\n +7 \(String(describing: phone))")
            
            let verificationCoordinator = VerificationCoordinator(assembly: self.assembly, root: self.root)
            
            self.childs.append(verificationCoordinator)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                verificationCoordinator.start()
            }
        }
        
        self.root.pushViewController(authController, animated: true)
    }
}
