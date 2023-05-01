import Foundation
import UIKit

final class PhoneTextFieldCoordinator: Coordinator<Assembly, UINavigationController, PhoneTextFieldContext> {
    
    
    override init(assembly: Assembly, context: PhoneTextFieldContext) {
        super.init(assembly: assembly, context: context)
    }
    
    override func make() -> UIViewController? {
        guard let context = context else {
            return nil
        }
        
        let controller = assembly.phoneTextFieldController()
        
        controller.didFieldChanged = context.didFieldChanged
        
        context.errorProvider(controller)
        
        return controller
    }
}
