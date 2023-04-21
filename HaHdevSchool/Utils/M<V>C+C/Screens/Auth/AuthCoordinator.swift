import UIKit

final class AuthCoordinator: Coordinator<Assembly, UINavigationController, Any> {
    
    struct Context {
        let phone: String
        let seconds: Int
        let finishFlow: (_ operationToken: String) -> Void
    }
    
    struct PhoneContext {
        let action: (_ phone: String, _ completion: @escaping () -> Void) -> Void
    }
    
    override init(assembly: Assembly) {
        super.init(assembly: assembly)
    }
    
    override func make() -> UIViewController? {
        let controller = assembly.authController()
        
        //----------
        let phoneCoordinator = assembly.phoneTextFieldCoordinator(
            context: .init(
                action: {
                    [weak controller] phone, update in
                    controller?.inputForm.phone = phone
                }
            )
        )
        
        setContent(
            coordinator: phoneCoordinator,
            on: controller,
            containerId: .phone
        )
        //        DispatchQueue.main.asyncAfter(deadline: .now()+4){
        //            self.removeContent(coordinator: phoneCoordinator,
        //                          on: controller,
        //                          containerId: .phone)
        //        }
        
        //----------
        
        controller.onVerification = { [weak self] phone, completion in
            guard let self = self, let phone = phone else {
                return
            }
            
            print("Отправлено смс для верификации номера:\n +7 \(String(describing: phone))")
            
            let verificationCoordinator = self.assembly.verificationCoordinator(
                context: .init(
                    phone: phone,
                    seconds: 41
                ) { [weak self] operationToken in
                    guard let self = self else {
                        return
                    }
                    self.backTo(coordinator: self, animated: true)
                    completion()
                }
            )
            
            
            self.start(coordinator: verificationCoordinator, on: self.root, animated: true)
        }
        
        ///////////////
        //        let coordinator = self.assembly.verificationCoordinator(
        //            context: .init(
        //                phone: "323432",
        //                seconds: 41) { [weak self] operationToken in
        //                    guard let self = self else {
        //                        return
        //                    }
        //                }
        //        )
        //
        //        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
        //            self.start(coordinator: coordinator, on: self.root, animated: true)
        //        }
        //
        //        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
        //            self.backTo(coordinator: self, animated: true)
        //        }
        ///////////////
        
        return controller
    }
}
