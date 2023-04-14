import UIKit

class AppCoordinator: Coordinator {
    
    init(assembly: Assembly, root: UINavigationController) {
        self.assembly = assembly
        self.root = root
    }

    private let assembly: Assembly
    private let root: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    var childs: [Coordinator] = []
    
    
    func start() {
        let authCoordinator = AuthCoordinator(assembly: assembly, root: root)
        
        switchTo(coordinator: authCoordinator)
    }
    

    
}
