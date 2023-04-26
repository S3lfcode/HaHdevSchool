import Foundation
import UIKit

final class PhoneTextFieldCoordinator: Coordinator<Assembly, UINavigationController, AuthCoordinator.PhoneContext> {
    
    
    override init(assembly: Assembly, context: AuthCoordinator.PhoneContext) {
        super.init(assembly: assembly, context: context)
    }
    
    override func make() -> UIViewController? {
        guard let context = context else {
            return nil
        }
        
        let controller = assembly.phoneTextFieldController()
        
        controller.phoneNum = context.getNumber
        
        return controller
    }
}
