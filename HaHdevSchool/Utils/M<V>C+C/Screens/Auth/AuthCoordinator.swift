import UIKit

final class AuthCoordinator: RootableCoordinator {
    
    init(assembly: Assembly) {
        self.assembly = assembly
    }
    
    private let assembly: Assembly
    
    var root: UINavigationController?
    
    weak var parentCoordinator: BaseCoordinator?
    var childs: [BaseCoordinator] = []
    
    func make() -> UIViewController? {
        let controller = assembly.authController()

        controller.onVerification = { [weak self] phone, completion in
            guard let self = self, let phone = phone else {
                return
            }
            
            print("Отправлено смс для верификации номера:\n +7 \(String(describing: phone))")
            
            let coordinator = self.assembly.verificationCoordinator(
                context: .init(
                    phone: phone,
                    seconds: 41) { operationToken in
                        
                        //Тут нужно вызвать что-то, что вызовет root.popViewcontroller
//                        self.backTo(coordinator: self)
                        //TODO: !!
                        completion()
                    }
            )
            
            self.start(coordinator: coordinator, on: self.root, animated: true)
        }
        
        return controller
    }
}
