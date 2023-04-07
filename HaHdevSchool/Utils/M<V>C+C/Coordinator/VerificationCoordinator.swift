import UIKit

class VerificationCoordinator: Coordinator {
    
    init(assembly: Assembly, root: UINavigationController) {
        self.assembly = assembly
        self.root = root
    }
    
    private let assembly: Assembly
    private let root: UINavigationController
    
    var childs: [Coordinator] = []
    
    func start() {
        let verificationController = assembly.verificationController()
        self.root.pushViewController(verificationController, animated: true)
    }
}
