import UIKit

final class AuthCoordinator: Coordinator<Assembly, UINavigationController, Void> {
    
    override init(assembly: Assembly) {
        super.init(assembly: assembly)
    }
    
    override func make() -> UIViewController? {
        let controller = assembly.authController()
        
        //MARK: TestCatalog-----
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            let catalogCoordinator = self.assembly.catalogCoordinator()
            self.start(coordinator: catalogCoordinator, on: self.root, animated: true)
        }
        
        //---------- TF(data) -> Auth(state) -> TF
        
        let phoneCoordinator = assembly.phoneTextFieldCoordinator(
            context: .init(
                didFieldChanged: { [weak controller] data in
    
                    controller?.changeData(phoneData: data)
                    
                },
                errorProvider: { [weak controller] errorProvider in
                    
                    controller?.onDisplayPhoneError = { error in
                        errorProvider.display(error: error)
                    }
                }
            )
        )
        
        //MARK: Test setContent function
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)){
            self.setContent(
                coordinator: phoneCoordinator,
                on: controller,
                containerId: .phone,
                animated: true
            )
        }
        
        //MARK: Test removeContent function
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+4){
//            self.removeContent(
//                coordinator: phoneCoordinator,
//                on: controller,
//                containerId: .phone,
//                animated: true
//            )
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
        
        //MARK: Test backTo function -----
        
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
        
        //--------
        
        return controller
    }
}
