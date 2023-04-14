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
//    func backTo(coordinator: BaseCoordinator?) {
//        
//        coordinator.
//        root?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
//    }
//}
