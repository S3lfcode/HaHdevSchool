import UIKit

final class VerificationCoordinator: Coordinator<Assembly, UINavigationController, VerificationContext> {
    
    override init(assembly: Assembly, context: VerificationContext) {
        super.init(assembly: assembly, context: context)
    }
    
    override func make() -> UIViewController? {
        guard let context = context else {
            return nil
        }
        
        let controller = assembly.verificationController(
            phone: context.phone,
            seconds: context.seconds
        )
        
        controller.onComplete = context.finishFlow
        
        return controller
    }
}
