import UIKit

final class VerificationCoordinator: Coordinator<Assembly, UINavigationController, AuthCoordinator.Context> {
    
    override init(assembly: Assembly, context: AuthCoordinator.Context) {
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
