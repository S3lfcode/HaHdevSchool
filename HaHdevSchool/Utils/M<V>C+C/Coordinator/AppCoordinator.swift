import Foundation
import UIKit

protocol Coordinator {
    var childs: [Coordinator] {get set}
    func start()
}

class AppCoordinator: Coordinator {
    
    init(assembly: Assembly, root: UINavigationController) {
        self.assembly = assembly
        self.root = root
    }

    private let assembly: Assembly
    let root: UINavigationController
    
    var childs: [Coordinator] = []
    
    func start() {
        let authCoordinator = AuthCoordinator(assembly: assembly, root: root)
        childs.append(authCoordinator)
        authCoordinator.start()
    }
    

    
}
