import UIKit

protocol BaseCoordinator: AnyObject {
    var parentCoordinator: BaseCoordinator? { get set }
    var childs: [BaseCoordinator] { get set }
    
    func make() -> UIViewController?
}

extension BaseCoordinator {
    func addChild(coordinator: BaseCoordinator) {
        coordinator.parentCoordinator = self
        childs.append(coordinator)
    }
}

protocol RootableCoordinator: BaseCoordinator {
    associatedtype Root
    
    var root: Root? { get set }
}

extension BaseCoordinator {
    func start<Coordinate: RootableCoordinator>(
        coordinator: Coordinate?,
        on navigationController: UINavigationController?,
        animated: Bool
    ) where Coordinate.Root == UINavigationController {
        guard
            let coordinator = coordinator,
            let navigationController = navigationController,
            let controller = coordinator.make()
        else {
            return
        }
        
        addChild(coordinator: coordinator)
        
        coordinator.root = navigationController
        
        let animated = !navigationController.viewControllers.isEmpty && animated
        navigationController.pushViewController(controller, animated: animated)
    }
    
}

//extension RootableCoordinator where Root == UINavigationController {
//    func backTo(coordinator: BaseCoordinator?, animated: Bool) {
//        guard
//            let coordinator = coordinator,
//            let root = root
//        else {
//            return
//        }
//        
//        let depth = coordinator.depth()
//        let newStack = root.viewControllers.prefix(max(root.viewControllers.count - depth, 1))
//        
//        root.setViewControllers(Array(newStack), animated: animated)
//    }
//}
//
//extension BaseCoordinator {
//    func depth() -> Int {
//        
//        let maxDepth = childs
//            .compactMap{ $0.depth() }
//            .max(by: >) ?? 0
//        
//        return maxDepth + 1
//    }
//}
