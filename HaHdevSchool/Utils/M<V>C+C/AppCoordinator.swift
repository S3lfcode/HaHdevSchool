import UIKit

class AppCoordinator: Coordinator {
    
    init(assembly: Assembly, root: UINavigationController) {
        self.assembly = assembly
        self.root = root
    }

    let assembly: Assembly
    let root: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    var childs: [Coordinator] = []
    
    
    func start() {
        let authCoordinator = AuthCoordinator(assembly: assembly, root: root)
        
        switchTo(coordinator: authCoordinator)
    }
    

    
}
