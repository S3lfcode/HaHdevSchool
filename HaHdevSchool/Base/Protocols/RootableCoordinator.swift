import UIKit

protocol RootableCoordinator: BaseCoordinator, AnyRootableCoordinator {
    associatedtype Root
    
    var root: Root? { get set }
}

extension RootableCoordinator {
    var anyRoot: Any? {
        root
    }
}

extension RootableCoordinator where Root == UINavigationController {
    func backTo(coordinator: BaseCoordinator?, animated: Bool) {
        guard
            let coordinator = coordinator,
            let root = root
        else {
            return
        }

        let depth = coordinator.depth() {
            ($0 as? AnyRootableCoordinator)?.anyRoot is UINavigationController
        }
        let newStack = root.viewControllers.prefix(max(root.viewControllers.count - depth, 1))
        
        root.setViewControllers(Array(newStack), animated: animated)
    }
}
