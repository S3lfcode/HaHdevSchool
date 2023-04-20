import UIKit

final class AuthCoordinator: Coordinator<Assembly, UINavigationController, Any> {
    
    struct Context {
        let phone: String
        let seconds: Int
        let finishFlow: (_ operationToken: String) -> Void
    }
    
    override init(assembly: Assembly) {
        super.init(assembly: assembly)
    }
    
    override func make() -> UIViewController? {
        let controller = assembly.authController()

        controller.onVerification = { [weak self] phone, completion in
            guard let self = self, let phone = phone else {
                return
            }
            
            print("Отправлено смс для верификации номера:\n +7 \(String(describing: phone))")
            
            let coordinator = self.assembly.verificationCoordinator(
                context: .init(
                    phone: phone,
                    seconds: 41) { [weak self] operationToken in
                        guard let self = self else {
                            return
                        }
//                        self.backTo(coordinator: self, animated: true)
                        completion()
                    }
            )
            
            
            self.start(coordinator: coordinator, on: self.root, animated: true)
        }
        
        ///////////////
        let coordinator = self.assembly.verificationCoordinator(
            context: .init(
                phone: "323432",
                seconds: 41) { [weak self] operationToken in
                    guard let self = self else {
                        return
                    }
//                        self.backTo(coordinator: self, animated: true)
//                    completion()
                }
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.start(coordinator: coordinator, on: self.root, animated: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.backTo(coordinator: self, animated: true)
        }
        ///////////////
        
        return controller
    }
}
