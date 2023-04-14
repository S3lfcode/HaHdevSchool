import UIKit

final class AppCoordinator: BaseCoordinator {
    
    init(assembly: Assembly) {
        self.assembly = assembly
    }

    private let assembly: Assembly
    
    weak var parentCoordinator: BaseCoordinator?
    var childs: [BaseCoordinator] = []
    
    
    func make() -> UIViewController? {
        let navigationController = assembly.navigationController
        
        start(
            coordinator: assembly.authCoordinator(),
            on: navigationController,
            animated: false
        )
        
        return navigationController
    }
    

    
}
