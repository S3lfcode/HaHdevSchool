import UIKit

class VerificationCoordinator: Coordinator {
    struct Context {
        let phone: String
        let seconds: Int
    }
    
    init(assembly: Assembly, root: UINavigationController, context: Context) {
        self.assembly = assembly
        self.root = root
        self.context = context
    }
    
    private let assembly: Assembly
    private let root: UINavigationController
    private let context: Context
    
    weak var parentCoordinator: Coordinator?
    var childs: [Coordinator] = []
    
    func start() {
        let verificationController = assembly.verificationController(
            phone: context.phone,
            seconds: context.seconds
        )
        
        root.pushViewController(verificationController, animated: true)
    }
}
