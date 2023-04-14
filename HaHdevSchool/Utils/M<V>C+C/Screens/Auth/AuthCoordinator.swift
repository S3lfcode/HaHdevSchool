import UIKit

class AuthCoordinator: Coordinator {    
    
    init(assembly: Assembly, root: UINavigationController) {
        self.assembly = assembly
        self.root = root
    }
    
    private let assembly: Assembly
    private let root: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    var childs: [Coordinator] = []
    
    func start() {
        let controller = assembly.authController()
        
        controller.onVerification = { [weak self] phone in
            guard let self = self, let phone = phone else {
                return
            }
            
            print("Отправлено смс для верификации номера:\n +7 \(String(describing: phone))")
            
            let coordinator = self.assembly.verificationCoordinator(context: .init(phone: phone, seconds: 40))
            
            self.switchTo(coordinator: coordinator)
        }
        
        root.pushViewController(controller, animated: !root.viewControllers.isEmpty)
    }
}
