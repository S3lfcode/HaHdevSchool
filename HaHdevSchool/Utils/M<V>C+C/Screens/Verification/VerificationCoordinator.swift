import UIKit

final class VerificationCoordinator: RootableCoordinator {
    
    
    struct Context {
        let phone: String
        let seconds: Int
        let finishFlow: (_ operationToken: String) -> Void
    }
    
    init(assembly: Assembly, context: Context) {
        self.assembly = assembly
        self.context = context
    }
    
    private let assembly: Assembly
    private let context: Context
    
    var root: UINavigationController?
    
    weak var parentCoordinator: BaseCoordinator?
    var childs: [BaseCoordinator] = []
    
    func make() -> UIViewController? {
        let controller = assembly.verificationController(
            phone: context.phone,
            seconds: context.seconds
        )
        
        controller.onComplete = context.finishFlow
//        controller.onComplete = { [weak self] operationToken in
//            self?.context.finishFlow(operationToken)
//        }
        
        return controller
    }
}
