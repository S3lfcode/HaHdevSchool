import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childs: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func switchTo(coordinator: Coordinator) {
        coordinator.parentCoordinator = self
        childs.append(coordinator)
        coordinator.start()
    }
}
