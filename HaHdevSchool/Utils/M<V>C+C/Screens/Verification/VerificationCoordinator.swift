import UIKit

class VerificationCoordinator: Coordinator {
    
    init(assembly: Assembly, root: UINavigationController) {
        self.assembly = assembly
        self.root = root
    }
    
    let assembly: Assembly
    let root: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    var childs: [Coordinator] = []
    
    func start() {
        let verificationController = assembly.verificationController()
        
        self.root.pushViewController(verificationController, animated: true)
    }
}
